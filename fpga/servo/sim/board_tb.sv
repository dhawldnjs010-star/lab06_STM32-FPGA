`timescale 1ns/1ps
// servo_board 보조 TB (학생 작성): 버튼을 떨림과 함께 누르고 있어도 한 번만 움직이는지,
// 제한(1000/2000 us)과 LED 단계 표시를 확인한다. button_pulse의 안정 시간을 4클록으로 줄였다.
module board_tb;
    initial begin $dumpfile("board_wave.vcd"); $dumpvars(0, board_tb); end
    reg clk=0,rst=1,bl=0,br=0;
    always #5 clk=~clk;
    wire servo; wire [7:0] led;
    servo_board dut(clk,rst,bl,br,servo,led);
    defparam dut.u_left.STABLE_CYCLES=4;  defparam dut.u_right.STABLE_CYCLES=4;
    defparam dut.u_servo.CLK_HZ=100000;
    // right=1이면 오른쪽, 0이면 왼쪽 버튼 (task 인자는 값 복사라 전역 신호를 직접 바꾼다)
    task press_bouncy(input bit right);
        integer j;
        begin
            for(j=0;j<4;j=j+1) begin @(negedge clk); if(right) br=j[0]^1; else bl=j[0]^1; end // 떨림
            @(negedge clk); if(right) br=1; else bl=1; repeat(20) @(negedge clk);  // 누르고 있음
            if(right) br=0; else bl=0; repeat(20) @(negedge clk);                  // 뗌
        end
    endtask
    integer k;
    initial begin
        repeat(2) @(negedge clk); rst=0;
        if(dut.us!==1500 || led!==8'b0001_1111) $fatal(1,"reset step led=%b",led);
        press_bouncy(1);
        if(dut.us!==1600 || led!==8'b0011_1111) $fatal(1,"one press = one step us=%0d led=%b",dut.us,led);
        for(k=0;k<6;k=k+1) press_bouncy(1);
        if(dut.us!==2000 || led!==8'hFF) $fatal(1,"right limit us=%0d",dut.us);
        for(k=0;k<12;k=k+1) press_bouncy(0);
        if(dut.us!==1000 || led!==8'h00) $fatal(1,"left limit us=%0d",dut.us);
        if(dut.u_servo.u_position.pulse_us!==dut.us) $fatal(1,"mirror mismatch");
        $display("PASS servo_board: bouncy press = 1 step, limits, LED steps"); $finish;
    end
    initial begin #200000; $fatal(1,"timeout"); end
endmodule

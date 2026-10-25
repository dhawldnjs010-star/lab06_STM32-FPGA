`timescale 1ns/1ps
// uart_cmd TB (학생 작성, LAB3 tb_uart_echo 방식). 1비트 = 8클록으로 줄여 모의 실행한다.
// MCU 모의 실행(과제7)과 같은 순서 "1122x0"을 보내고, PC로 돌아오는 바이트와 LED를 확인한다.
module tb;
    initial begin $dumpfile("wave.vcd"); $dumpvars(0, tb); end
    localparam integer DIV=8;
    reg clk_50mhz=0,rst_p=1,uart_rxd=1;
    wire uart_txd, cmd_led;
    integer checks=0,i,k;
    reg [7:0] observed;
    reg [7:0] seq [0:6];
    reg exp_led [0:6];
    always #10 clk_50mhz=~clk_50mhz;
    uart_cmd #(.CLK_HZ(800),.BAUD(100)) dut
      (.clk_50mhz(clk_50mhz),.rst_p(rst_p),.uart_rxd(uart_rxd),.uart_txd(uart_txd),.cmd_led(cmd_led));
    task send_byte(input [7:0] value);
    begin
      uart_rxd=0;repeat(DIV)@(posedge clk_50mhz);
      for(i=0;i<8;i=i+1)begin uart_rxd=value[i];repeat(DIV)@(posedge clk_50mhz);end
      uart_rxd=1;repeat(DIV)@(posedge clk_50mhz);
    end endtask
    task receive_byte(input [7:0] expected);
    integer j;
    begin
      observed=0;@(negedge uart_txd);repeat(DIV+DIV/2)@(posedge clk_50mhz);
      for(j=0;j<8;j=j+1)begin observed[j]=uart_txd;repeat(DIV)@(posedge clk_50mhz);end
      if(observed!==expected)$fatal(1,"echo=%h expected=%h",observed,expected);
      repeat(DIV)@(posedge clk_50mhz);
    end endtask
    initial begin
      seq[0]="1"; exp_led[0]=1;   // 켜기
      seq[1]="1"; exp_led[1]=1;   // 다시 켜기: 계속 켜짐
      seq[2]="2"; exp_led[2]=0;   // 반전
      seq[3]="2"; exp_led[3]=1;   // 반전
      seq[4]="x"; exp_led[4]=1;   // 그 밖의 문자: 유지
      seq[5]="0"; exp_led[5]=0;   // 끄기
      seq[6]=8'h01; exp_led[6]=0; // 숫자 1(0x01)은 명령 '1'(0x31)이 아니다
      repeat(4)@(posedge clk_50mhz);
      if(cmd_led!==0 || uart_txd!==1)$fatal(1,"reset state");
      rst_p=0;
      for(k=0;k<7;k=k+1) begin
        fork send_byte(seq[k]); receive_byte(seq[k]); join
        if(cmd_led!==exp_led[k])$fatal(1,"cmd=%h led=%b expected=%b",seq[k],cmd_led,exp_led[k]);
        checks=checks+1;
      end
      if(dut.rx_framing_error)$fatal(1,"unexpected framing error");
      @(negedge clk_50mhz); rst_p=1; @(posedge clk_50mhz); #1;
      if(cmd_led!==0)$fatal(1,"reset after running");
      $display("PASS uart_cmd: echo 7 bytes, LED 0/1/2 commands, other byte hold, reset");$finish;
    end
    initial begin #200000;$fatal(1,"timeout");end
endmodule

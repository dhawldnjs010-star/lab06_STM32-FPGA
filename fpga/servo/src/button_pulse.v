`timescale 1ns/1ps
// 버튼 원시 신호 -> 누를 때마다 한 클록 길이 펄스 (학생 작성, 보드 구현용).
// 2단 동기화 뒤 STABLE_CYCLES 동안 값이 유지되면 받아들이고, 0 -> 1 변화에서 한 번만 펄스를 낸다.
module button_pulse #(parameter integer STABLE_CYCLES = 500_000)( // 50 MHz에서 10 ms
    input wire clk_50mhz, rst_p, btn,
    output reg pulse
);
    (* ASYNC_REG="TRUE" *) reg [1:0] sync;
    reg level;
    reg [31:0] count;
    always @(posedge clk_50mhz) begin
        if (rst_p) begin sync<=0; level<=0; count<=0; pulse<=0; end
        else begin
            sync <= {sync[0], btn};
            pulse <= 0;
            if (sync[1] == level) count <= 0;
            else if (count == STABLE_CYCLES-1) begin
                count <= 0; level <= sync[1];
                if (sync[1]) pulse <= 1;
            end else count <= count + 1;
        end
    end
endmodule

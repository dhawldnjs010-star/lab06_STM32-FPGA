`timescale 1ns/1ps
// 보드 구현용 최상위 (학생 추가). 수업 제공 servo_ctrl은 버튼 한 번에 한 클록 펄스를 받으므로
// 버튼 원시 신호를 button_pulse로 바꿔 연결한다. LED는 현재 펄스 폭 단계를 표시한다.
module servo_board(
    input wire clk_50mhz, rst_p, btn_left, btn_right,
    output wire servo,
    output wire [7:0] led_out
);
    wire left_pulse, right_pulse;
    button_pulse u_left (clk_50mhz, rst_p, btn_left,  left_pulse);
    button_pulse u_right(clk_50mhz, rst_p, btn_right, right_pulse);
    servo_ctrl u_servo(clk_50mhz, rst_p, left_pulse, right_pulse, servo);
    // LED 표시용으로 같은 펄스를 받는 servo_position을 하나 더 두어 현재 폭(us)을 얻는다.
    // (servo_ctrl 안의 신호를 계층 이름으로 꺼내면 합성에서 지원되지 않으므로)
    wire [31:0] us;
    servo_position u_mirror(clk_50mhz, rst_p, left_pulse, right_pulse, us);
    // 1000~2000 us -> 0~10 단계. 단계 수만큼 아래 LED부터 켠다 (0단계 전부 꺼짐, 8단계 이상 전부 켜짐).
    wire [3:0] stepno = (us - 1000) / 100;
    genvar i;
    generate for (i = 0; i < 8; i = i + 1) begin : g_led
        assign led_out[i] = (stepno > i);
    end endgenerate
endmodule

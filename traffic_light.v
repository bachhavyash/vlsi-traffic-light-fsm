// ============================================================
// Project   : Traffic Light Controller (FSM)
// Author    : Yashganesh Bachhav
// College   : LGNSCOE, Nashik (SPPU)
// Domain    : VLSI Design | Verilog HDL
// Description: Moore FSM with 4 states for a 2-way intersection
//              RED, GREEN, YELLOW, ALL_RED (safe transition)
// ============================================================

module traffic_light_fsm (
    input  clk,
    input  rst,
    output reg [2:0] road_A, // {RED, YELLOW, GREEN}
    output reg [2:0] road_B  // {RED, YELLOW, GREEN}
);

    // State encoding
    parameter S0_A_GREEN  = 2'b00;  // Road A: Green,  Road B: Red
    parameter S1_A_YELLOW = 2'b01;  // Road A: Yellow, Road B: Red
    parameter S2_B_GREEN  = 2'b10;  // Road A: Red,    Road B: Green
    parameter S3_B_YELLOW = 2'b11;  // Road A: Red,    Road B: Yellow

    reg [1:0] state, next_state;
    reg [3:0] timer;

    // Durations (in clock cycles)
    parameter GREEN_TIME  = 4'd5;
    parameter YELLOW_TIME = 4'd2;

    // State register
    always @(posedge clk) begin
        if (rst) begin
            state <= S0_A_GREEN;
            timer <= 4'd0;
        end else begin
            if (timer == 4'd0)
                state <= next_state;
            else
                timer <= timer - 1;
        end
    end

    // Next state + timer logic
    always @(*) begin
        case (state)
            S0_A_GREEN:  begin next_state = S1_A_YELLOW; end
            S1_A_YELLOW: begin next_state = S2_B_GREEN;  end
            S2_B_GREEN:  begin next_state = S3_B_YELLOW; end
            S3_B_YELLOW: begin next_state = S0_A_GREEN;  end
            default:     begin next_state = S0_A_GREEN;  end
        endcase
    end

    // Output logic (Moore)
    // road = {RED, YELLOW, GREEN}
    always @(*) begin
        case (state)
            S0_A_GREEN:  begin road_A = 3'b001; road_B = 3'b100; end // A:G, B:R
            S1_A_YELLOW: begin road_A = 3'b010; road_B = 3'b100; end // A:Y, B:R
            S2_B_GREEN:  begin road_A = 3'b100; road_B = 3'b001; end // A:R, B:G
            S3_B_YELLOW: begin road_A = 3'b100; road_B = 3'b010; end // A:R, B:Y
            default:     begin road_A = 3'b100; road_B = 3'b100; end // All RED
        endcase
    end

endmodule

// ============================================================
// Testbench : Traffic Light Controller FSM
// ============================================================

`timescale 1ns/1ps

module traffic_light_tb;

    reg  clk, rst;
    wire [2:0] road_A, road_B;

    traffic_light_fsm uut (
        .clk(clk), .rst(rst),
        .road_A(road_A), .road_B(road_B)
    );

    always #5 clk = ~clk;

    // Helper function to decode light
    task display_lights;
        input [2:0] A;
        input [2:0] B;
        reg [6:0] stateA, stateB;
        begin
            case (A)
                3'b001: $write("GREEN ");
                3'b010: $write("YELLW ");
                3'b100: $write("RED   ");
                default:$write("?     ");
            endcase
            $write("| ");
            case (B)
                3'b001: $write("GREEN");
                3'b010: $write("YELLW");
                3'b100: $write("RED  ");
                default:$write("?    ");
            endcase
        end
    endtask

    integer i;

    initial begin
        $display("====================================================");
        $display(" Traffic Light FSM — Yashganesh Bachhav");
        $display("====================================================");
        $display(" Cycle | Road A  | Road B  | State");
        $display("-------|---------|---------|------");

        clk=0; rst=1; #12; rst=0;

        for (i = 0; i < 20; i = i + 1) begin
            #10;
            $write("  %3d  | ", i);
            display_lights(road_A, road_B);
            case ({road_A, road_B})
                6'b001100: $display(" | A_GREEN");
                6'b010100: $display(" | A_YELLOW");
                6'b100001: $display(" | B_GREEN");
                6'b100010: $display(" | B_YELLOW");
                default:   $display(" | RESET/ALL_RED");
            endcase
        end

        $display("====================================================");
        $display(" Simulation Complete!");
        $display("====================================================");
        $finish;
    end

endmodule

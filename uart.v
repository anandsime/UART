module uart (
  input wire clk,
  input wire reset,
  input wire rx,
  output wire tx
);

  reg [7:0] data;
  reg [2:0] state;
  reg [3:0] count;

  parameter IDLE = 3'b000;
  parameter START = 3'b001;
  parameter DATA = 3'b010;
  parameter STOP = 3'b011;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else
      case (state)
        IDLE: begin
          if (!rx)
            state <= START;
        end

        START: begin
          count <= 3'b000;
          state <= DATA;
        end

        DATA: begin
          if (count < 8) begin
            data[count] <= rx;
            count <= count + 1;
          end
          else
            state <= STOP;
        end

        STOP: begin
          state <= IDLE;
        end
      endcase
  end

  assign tx = (state == IDLE) ? 1'b1 : 1'b0;

endmodule


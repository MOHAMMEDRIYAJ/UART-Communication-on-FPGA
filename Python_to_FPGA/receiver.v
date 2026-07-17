module uart_top(input clk,reset,rx_channel,
				output rx_done,
                output [7:0] prl_data);

  wire rx_en;  

  baud_gen baud_rate_generator(clk,reset,rx_en);
  
  uart_rx Receiver(clk,reset,rx_en,rx_channel,prl_data,rx_done);
  
endmodule



module baud_gen #(parameter CLK_freq = 100000000,
                  parameter Baud_rate = 9600,
                  parameter Sampling = 16 )
  (input clk , reset , output  rx_en);
  // Edge cases not considered , So use only standard baud rate
  
  localparam integer rx_div = CLK_freq / (Baud_rate * Sampling);

  reg [$clog2(rx_div)-1 : 0] rx_cnt;
  
  always @(posedge clk) begin
    if(reset)
      rx_cnt<=0;
    else if(rx_cnt==rx_div-1)
      rx_cnt<=0;
    else 
      rx_cnt<=rx_cnt+1'b1;
  end
  assign rx_en = (rx_cnt == rx_div-1);
endmodule 

module uart_rx(input clk, reset, rx_en, rx,
               output reg [7:0] prl_data,
			   output reg rx_done);

  localparam idle    = 2'b00;
  localparam receive = 2'b01;
  localparam stop    = 2'b10;

  reg [7:0] temp;
  reg [2:0] count;
  reg [3:0] sample;
  reg [1:0] state;
  reg rx1,rx2;

  always @(posedge clk) begin
    if(reset) begin
      state    <= idle;
      temp     <= 8'b0;
      count    <= 3'b0;
      sample   <= 4'b0;
      prl_data <= 8'b0;
	  rx1 <= 1'b1;
      rx2 <= 1'b1;
	  rx_done <= 1'b0;
    end
    else begin
      rx1 <= rx;
      rx2 <= rx1;
      case(state)

        idle :
          begin
            if(rx_en) begin
              if(rx2 == 1'b0)begin
			    rx_done <= 1'b0;
                if(sample == 4'd15) begin
                  state <= receive;
                  sample <= 4'd0;
                  count <= 3'b0;
                end
                else 
                  sample <= sample + 1'b1;
              end
              else 
                sample <= 4'd0;
            end
          end

        receive :
          begin
            if(rx_en) begin
              if(sample == 4'd8) begin
                temp [count] <= rx2;
                sample <= sample + 1'b1;
              end
              else if(sample == 4'd15) begin
                sample <= 4'd0;
                if(count == 3'd7) begin 
                  state <= stop;
                  count <= 3'd0;
                end
                else 
                  count <= count + 1'b1;
              end
              else 
                sample <= sample + 1'b1;
            end
            else 
              state <= receive;
          end
        
        stop : 
          begin
            if(rx_en)begin
              if(rx2 == 1'b1)begin 
                if(sample == 4'd15) begin
				  rx_done <= 1'b1;
                  prl_data <= temp;
                  state <= idle;
                  sample <= 4'b0;
                end
                else begin
                  sample <= sample + 1'b1;
                end
              end
              else begin
                state <= idle;
                sample <= 4'b0;
              end
            end
            else 
              state <= stop;
          end
		default: state <= idle;
      endcase
    end
  end
endmodule

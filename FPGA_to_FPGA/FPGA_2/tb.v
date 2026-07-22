`timescale 1ns/1ps
module uart_top_tb;
    reg clk,reset,wr_en,rx_channel;
    reg [7:0] inp_data;
    wire tx_channel;
    wire [7:0] prl_data;
    wire rx_done;
    
    uart_top dut(clk,reset,wr_en,rx_channel,inp_data,tx_channel,prl_data,rx_done);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    task initialize;
    begin
        $display("Initializing Inputs");
        {wr_en,reset,inp_data}= 10'b0;
        rx_channel = 1;
    end
    endtask
    
    task RESET;
    begin
        $display("Applying Reset");
        @(negedge clk) reset = 1;
        @(negedge clk) reset = 0;
    end
    endtask
    
    task Send_byte(input [7:0] data);
    begin
        $display("Sending Byte ...");
        @(negedge clk)
            wr_en = 1;
            $display("Write Enable Asserted");
            inp_data = data;
            $display("Transmitting Data = %b",inp_data);
        @(negedge clk)
            wr_en = 0;
            $display("Write Enable deasserted");
    end
    endtask
    
    always @(*) rx_channel = tx_channel;
    
    initial begin
        initialize;
        RESET;
        Send_byte(8'b0010_0111);
        wait(rx_done)
        $display("Received Successfully");
        Send_byte(8'b0100_0111);
        wait(rx_done) 
        $display("Received Successfully");
        #100 $finish;
    end
        
endmodule
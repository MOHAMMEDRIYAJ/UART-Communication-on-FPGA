module uart_top_tb;
    reg clk,reset,rx_channel;
    wire rx_done;
    wire [7:0] prl_data;
    
    uart_top dut(clk,reset,rx_channel,rx_done,prl_data);
    
    parameter CLK_PERIOD = 10;
    parameter CLOCK = 100000000;
    parameter BAUD_RATE = 9600;
    parameter TX_TICK = (CLOCK / BAUD_RATE)*CLK_PERIOD;
    
    initial clk = 0;
    always #5 clk=~clk;
    
    reg [7:0] data_in_reference;
    task initialize;
    begin
        $display("Initializing");
        reset = 0;
        rx_channel = 1;
        data_in_reference = 0;
    end
    endtask
    
    task RESET;
    begin
        $display("Reset is Applied");
        @(negedge clk) reset = 1;
        @(negedge clk) reset = 0;
    end
    endtask
    
    task Send_byte(input [7:0] data);
    integer i;
    begin
        data_in_reference = data;
        $display("Sending Byte...");
        rx_channel = 1;
        #TX_TICK;
        rx_channel = 0; // Start Bit
        #TX_TICK;
        for(i=0;i<8;i=i+1)begin
            rx_channel = data[i]; // data
            #TX_TICK;
        end
        rx_channel = 1; // Stop Bit
        #TX_TICK;
    end
    endtask
    
    initial begin
        initialize;
        RESET;
        Send_byte(8'b0010_0111);
        wait(rx_done)
        $display("Byte Received");
        Send_byte(8'b0110_1001);
        wait(rx_done)
        $display("Byte Received");
        #50 $finish;
    end
    
endmodule
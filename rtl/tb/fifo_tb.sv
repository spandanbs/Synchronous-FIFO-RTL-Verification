module fifo_tb;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] data_in;
wire [7:0] data_out;
wire full;
wire empty;

// Scoreboard storage
reg [7:0] expected_data [0:10];
integer w_ptr = 0;
integer r_ptr = 0;

// Instantiate DUT
fifo dut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// VCD dump
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, fifo_tb);
end

// Clock
always #5 clk = ~clk;

// Reset
initial begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;
    #10 rst = 0;
end

// Stimulus
initial begin
    #20;

    repeat (5) begin
        @(posedge clk);
        wr_en = 1;
        data_in = $random;
        expected_data[w_ptr] = data_in;
        w_ptr = w_ptr + 1;
    end

    @(posedge clk);
    wr_en = 0;

    repeat (5) begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    #50;
    $finish;
end

// Scoreboard check
always @(posedge clk) begin
    if (rd_en && !empty) begin
        if (data_out == expected_data[r_ptr])
            $display("Correct data at time %0t", $time);
        else
            $display("ERROR: Data mismatch at time %0t", $time);

        r_ptr = r_ptr + 1;
    end
end

endmodule

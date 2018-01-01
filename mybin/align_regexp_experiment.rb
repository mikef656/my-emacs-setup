
mux_constant_array = [
"   -----------------------------------------------------------------------------\n",
"   constant C_SCH1                   : integer := 8;\n",
 "   constant C_REGCFG                   : integer := 8;\n",
 "   constant C_SEGRX1   : integer := 8;\n"
 ]


signals_array =
["   -----------------------------------------------------------------------------\n   -- Internal connections to cpumsg router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal cpumsg_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal cpumsg_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal cpumsg_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal cpumsg_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal cpumsg_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to ctlmsg router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal ctlmsg_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ctlmsg_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ctlmsg_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ctlmsg_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal ctlmsg_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to gbusmsg router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal gbusmsg_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal gbusmsg_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal gbusmsg_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal gbusmsg_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal gbusmsg_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to frc1 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal frc1_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal frc1_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal frc1_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal frc1_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal frc1_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to frc2 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal frc2_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal frc2_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal frc2_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal frc2_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal frc2_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to dma router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal dma_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal dma_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal dma_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal dma_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal dma_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to gio1 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal gio1_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal gio1_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal gio1_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal gio1_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal gio1_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to ddr_read_out1 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal ddr_read_out1_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ddr_read_out1_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ddr_read_out1_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ddr_read_out1_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal ddr_read_out1_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to ddr_read_out2 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal ddr_read_out2_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ddr_read_out2_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ddr_read_out2_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal ddr_read_out2_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal ddr_read_out2_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to flash router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal flash_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal flash_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal flash_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal flash_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal flash_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to regcfg router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal regcfg_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal regcfg_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal regcfg_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal regcfg_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal regcfg_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to sch1 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal sch1_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal sch1_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal sch1_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal sch1_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal sch1_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n", "   -----------------------------------------------------------------------------\n   -- Internal connections to sch2 router\n   -----------------------------------------------------------------------------\n   -- data direction: router -> mux \n   signal sch2_router_blockid_port              :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal sch2_router_pwr_steer_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal sch2_router_next_node_port            :T_ROUTER_OUT_PORT_OUTPUTS;\n   signal sch2_router_previous_node_port        :T_ROUTER_OUT_PORT_OUTPUTS;\n   --\n   -- data direction: mux -> router \n   signal sch2_router_ready                     :T_ROUTER_TOP_READY;\n   --\n   \n"]


def align_regexp (array_of_strings,regexp)
  if regexp == (""or //)
    puts "--- WARNING REGEXP EMPTY ----"
    array_of_strings
   else
   rows = array_of_strings.map{ |line| line.partition(regexp) }
   pos = rows.map { |row| row[0].strip.size }.max
   rows.map { |row| row[0] = row[0].strip.ljust(pos); row.join }
   end
end


class Array
  def my_align_regexp (regexp)
    if regexp == (""or //)
      puts "--- WARNING REGEXP EMPTY ----"
      array_of_strings
    else
      rows = self.map{ |line| line.partition(regexp)}
      #
      pos = rows.map { |row| 
                     # if the regexp did not match then count its length as 0
                     if (row[2] == "")
                       0
                     else  
                       row[0].rstrip.size 
                     end
                     }.max
      #
      rows.map{ |row| 
                # if the regexp did not match then don't apply the correction
                if (row[2] == "")
                  row[0] = row[0].strip.ljust(0)
                else
                  row[0] = row[0].rstrip.ljust(pos+1)
                end
                #
                row.join 
              }
     end
  end
end


puts"one more time"
temp = mux_constant_array.my_align_regexp(/:/)
puts temp

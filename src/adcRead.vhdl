library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity adcRead is
    port ( OSC_FPGA : in  std_logic;
     --   LED	: out std_logic;
        ADC_CLK, ADC_CS : out std_logic;
        ADC1_SDO: in std_logic;
		  ADC2_SDO: in std_logic;
        PRU_READY : out std_logic;
        PRU_DATA : out std_logic_vector(12 - 1 downto 0)

         );
end adcRead;

architecture Behavioral of adcRead is
    component adcReader
	      generic (
			          cycle_length: natural
			        );
         port ( clk : in std_logic;
                sclk : out std_logic;
                cs : out std_logic;
                sdo1 : in std_logic;
					 sdo2 : in std_logic;
                data_out : out std_logic_vector(11 downto 0);
                ready : out std_logic
              );
    end component;

    signal data : std_logic_vector (11 downto 0);
	 signal clk_div : std_logic;
begin
    inst_adcReader : adcReader 
	 generic map (
	        cycle_length => 25
			       )
	 port map (
           clk => OSC_FPGA,
           sclk=> ADC_CLK,
           cs => ADC_CS,
           sdo1 => ADC1_SDO,
			  sdo2 => ADC2_SDO,
           data_out => PRU_DATA,
           ready => PRU_READY
    );
 
	
--	 clk_divider : process  (OSC_FPGA)
--	 variable count :  integer :=0;
--	 begin
--	 if rising_edge( OSC_FPGA) then
--		      count:= count +1;
--				if count > 0 then
--				   count := 0;
--					 clk_div <= not clk_div;
--				end if;
--	 end if;
--	 end process clk_divider;
end Behavioral;

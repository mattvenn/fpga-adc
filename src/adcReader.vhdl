library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity adcReader is
    generic (
	     cycle_length : natural
    );
    port ( clk : in std_logic;
           sclk : out std_logic;
			  
           cs : out std_logic;
           sdo1 : in std_logic;
			  sdo2 : in std_logic;
           data_out : out std_logic_vector (11 downto 0);
           ready : out std_logic -- PRU clocked on falling edge
			);
end adcReader;

architecture Behavioral of adcReader is
    signal data2: std_logic_vector (11 downto 0);
	 signal data1: std_logic_vector ( 11 downto 0);
	 signal data2_sto: std_logic_vector (11 downto 0);
begin
    sclk <= clk;
    process (clk)
	     variable current_bit : integer := 0;
		  variable count :  integer :=0;
    begin
	     if clk'event and clk = '0' then
		      if current_bit = 0 then
				    cs <= '0';
                 
				end if;
				if current_bit = 16 then
				    cs <= '1';
				end if;
        end if;
		  if clk'event and clk = '1' then
		      current_bit := current_bit+1;
				if current_bit = cycle_length then
				    current_bit := 0;
				end if;
		      if current_bit >= 4 and current_bit <=15 then
				    data1(15-current_bit) <= sdo1;
					 data2(15-current_bit) <= sdo2;
					 
				end if;
				if current_bit = 16 then
				       ready <= '1';
					 data_out <= data1;
					 data2_sto <= data2;
					 -- data_out <= std_logic_vector( to_unsigned(count,12));
--					 count := count + 1;
--					 if count >= 4096 then
--						count:= 0;
--						end if;
                  
				end if;
				if current_bit = 2 then
						data_out <= data2_sto;
						ready <= '0';
				end if;
		  end if;
    end process;
end Behavioral;

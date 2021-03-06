library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bitExtension is

	port(
		i_SignSel	: in std_logic;
		i_bit16		: in std_logic_vector(15 downto 0);
		o_bit32	        : out std_logic_vector(31 downto 0));

end bitExtension;

architecture structural of bitExtension is

component mux2t1_N is
   port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(31 downto 0);
       i_D1         : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));

end component;
signal s_MuxRes : std_logic_vector(31 downto 0);
signal s_32bit0EXT, s_32bitSignEXT : std_logic_vector(31 downto 0);

begin
s_32bit0EXT <= std_logic_vector(resize(unsigned(i_bit16), s_32bit0EXT'length));
s_32bitSignEXT <= std_logic_vector(resize(signed(i_bit16), s_32bitSignEXT'length));
MuxBIT: mux2t1_N port map(
	i_S => i_SignSel,
	i_D0 => s_32bit0EXT,
	i_D1 => s_32bitSignEXT,
	o_O  => o_bit32);

end architecture;
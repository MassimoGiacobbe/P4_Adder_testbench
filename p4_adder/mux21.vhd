-- File              : mux21.vhd
--
-- Authors           : Fabio Scatozza      <s315216@studenti.polito.it>
--                     Isacco Delpero      <s314713@studenti.polito.it>
--                     Leonardo Cerruti    <s317664@studenti.polito.it>
--
-- Date              : 19.04.2023
-- Last Modified Date: 30.07.2023
--
-- Copyright (c) 2023 
--
-- Licensed under the Solderpad Hardware License v 2.1 (the "License");
-- you may not use this file except in compliance with the License, or,
-- at your option, the Apache License version 2.0.
-- You may obtain a copy of the License at
--
--     https://solderpad.org/licenses/SHL-2.1/
--
-- Unless required by applicable law or agreed to in writing, any work
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

library IEEE;
use IEEE.std_logic_1164.all;

entity mux21 is
  generic (nbit_g: integer);
  port (
    a:   in   std_logic_vector(nbit_g-1 downto 0); -- selected with sel = '1'
    b:   in   std_logic_vector(nbit_g-1 downto 0);
    sel: in   std_logic;
    y:   out  std_logic_vector(nbit_g-1 downto 0)
  );
end entity;

architecture behavioral of mux21 is
begin
  y <= a when sel = '1' else
       b;
end architecture;

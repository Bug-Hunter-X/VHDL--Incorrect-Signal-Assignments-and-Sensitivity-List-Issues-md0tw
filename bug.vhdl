In VHDL, a common but subtle error arises from improper handling of signal assignments within processes and the sensitivity list.  Consider this example:

```vhdl
process (clk)
begin
  if rising_edge(clk) then
    if some_condition then
      data_reg <= data_in;
    end if;
  end if;
  -- INCORRECT: Missing sensitivity to data_in
data_out <= data_reg; 
end process;
```

The `data_out <= data_reg;` assignment is outside the `if rising_edge(clk)` block. While seemingly harmless, this creates a latch.  `data_out` will update whenever `data_reg` changes, regardless of the clock. This can lead to unpredictable behavior and metastability issues.  The correct approach is to include `data_in` in the process's sensitivity list, or to place the assignment within the clocked `if` statement:

```vhdl
process (clk, data_in) -- Corrected: data_in added to sensitivity list
begin
  if rising_edge(clk) then
    if some_condition then
      data_reg <= data_in;
    end if;
    data_out <= data_reg; -- Now correctly clocked
  end if;
end process;
```

Another example involves using `elsif` incorrectly without a default case:

```vhdl
process (select)
begin
  if select = '0' then
    data_out <= a;
  elsif select = '1' then
    data_out <= b;
  -- Missing default case
end process;
```
If `select` has a value other than '0' or '1',  `data_out`'s value is unpredictable and will likely retain its previous value, potentially leading to unexpected behavior.
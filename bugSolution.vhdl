The solution involves careful management of signal assignments within processes and ensuring that the sensitivity list accurately reflects all signals that affect the output.  Always include all inputs in the sensitivity list if they directly impact outputs outside a clocked block. For conditional statements, always include a default case to ensure predictable behavior when the condition is not met:

```vhdl
process (clk, data_in)
begin
  if rising_edge(clk) then
    if some_condition then
      data_reg <= data_in;
    end if;
    data_out <= data_reg; 
  end if;
end process;

process (select)
begin
  case select is
    when '0' => data_out <= a;
    when '1' => data_out <= b;
    when others => data_out <= c; -- Default case added
  end case;
end process;
```

By using these practices, developers can avoid unexpected latches and improve the correctness and reliability of their VHDL designs.
with utest;
with lua;
with lua.lib;

procedure loadfile1 is
  use type lua.error_t;

  ls: lua.state_t;
  ec: lua.error_t;
begin
  ls := lua.open;
  lua.lib.open_base (ls);

  ec := lua.load_file (ls, "test.lua");
  if ec /= lua.lua_error_none then
    utest.fail (1, lua.to_string (ls, -1));
  end if;

exception
  when others => utest.fail (2, "unexpected exception");
end loadfile1;

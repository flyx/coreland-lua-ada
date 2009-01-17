with lua;
with raiser;
with utest;

-- ensure exceptions can be passed through liblua

procedure except1 is
  ls     : lua.state_t;
  caught : boolean := false;

  use type lua.state_t;
  use type lua.number_t;
begin
  ls := lua.open;

  lua.at_panic
    (state          => ls,
     panic_function => raiser.raiser'access);

  begin
    lua.push_number (ls, -1.0);
    lua.call (ls, 1, 1);
  exception
    when raiser.raiser_error =>
      caught := true;
  end;

  utest.check
    (check   => caught,
     message => "failed to catch exception");
end except1;

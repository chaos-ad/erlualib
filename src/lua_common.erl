-module(lua_common).

-include("lua.hrl").

-export([command/2, receive_valued_response/0]).

command(#lua{port=Port}, Data) ->
    port_command(Port, term_to_binary(Data)).

receive_valued_response() ->
    receive
        {erlualib, ok} -> ok;
        {erlualib, {ok, Str}} -> Str;
        {erlualib, {throw, Throw}} -> throw(Throw);
        {erlualib, Other} -> throw({unknown_return, Other})
    after ?STD_TIMEOUT ->
        error(timeout)
    end.

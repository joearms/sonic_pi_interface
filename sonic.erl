-module(sonic).
-compile(export_all).

%% start sonic pi 
%% then run me


%% to UDP port 4557
%% osc messages "/run_code" "PLAY 50\n"

test() ->
    run_code(["sample :ambi_lunar_land\n",
	      make_scale()]).

make_scale() ->
    for(50,80, 
       fun(I) ->
	       ["play ",integer_to_list(I),"\n",
		"sleep 0.2\n"]
       end).

for(Max,Max,F) -> [F(Max)];
for(I,Max,F)   -> [F(I)|for(I+1,Max,F)].

run_code(Prog) ->
    P1 = lists:flatten(Prog),
    io:format("Run:~s~n",[P1]),
    M = {message, "/run-code", [P1]},
    E = osc_lib:encode(M),
    {ok, Socket} = gen_udp:open(0,[binary]),
    %% io:format("socket=~p message=~p~n",[Socket,E]),
    ok = gen_udp:send(Socket, "localhost", 4557, E),
    %% io:format("V=~p~n",[V]),
    gen_udp:close(Socket).
   
    
    


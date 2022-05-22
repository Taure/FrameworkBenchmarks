-module(nova_app_main_controller).
-export([
         json_serialize/1
        ]).

json_serialize(_Req) ->
    {json, #{message => <<"Hello world!">>}}.

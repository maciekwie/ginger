-module(ginger_adlib_client).

-export([
    listdatabases/1,
    search/2
]).

-include_lib("zotonic.hrl").

listdatabases(Context) ->
    case request(mod_ginger_adlib:endpoint(Context), [{command, <<"listdatabases">>}]) of
        undefined ->
            [];
        #{<<"adlibJSON">> := #{<<"recordList">> := #{<<"record">> := Records}}} ->
            Records
    end.

search(Params, Context) ->
    request(mod_ginger_adlib:endpoint(Context), Params).
    
request(undefined, _Params) ->
    throw({error, adlib_url_must_be_defined});
request(Endpoint, Params) ->
    WithDefaultParams = [{output, json}, {xmltype, grouped} | Params],
    Url = binary_to_list(Endpoint) ++ "?" ++ mochiweb_util:urlencode(WithDefaultParams),
    
    lager:debug("Adlib request: ~p", [Url]),

    case httpc:request(Url) of
        {ok, {
            {_HTTP, 200, _OK},
            _Headers,
            []
        }} ->
            undefined;
        {ok, {
            {_HTTP, 200, _OK},
            _Headers,
            Body
        }} ->
            try
                jsx:decode(z_convert:to_binary(Body), [return_maps])
            catch
                error:badarg ->
                    lager:error("Could not decode Adlib response: ~p", [Body]),
                    undefined
            end;
        {ok, {
            {_HTTP, 404, _NotFound},
            _Headers,
            _Body
        }} ->
            lager:error("404: ~p", [Url]),
            undefined;
        Response ->
            lager:info("Adlib client error for URL ~p: ~p", [Url, Response]),
            undefined
    end.

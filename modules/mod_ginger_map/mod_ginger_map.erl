%% @author Driebit <info@driebit.nl>
%% @copyright 2014

-module(mod_ginger_map).
-author("Driebit <info@driebit.nl>").

-mod_title("Ginger Maps").
-mod_description("Ginger Maps").
-mod_prio(500).
-mod_depends([mod_geo]).

-export([
    init/1
]).

init(Context) ->
    ginger_logger:deprecated(?MODULE, Context).

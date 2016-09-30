%% @doc This module logs syslog formatted messages over UDP
-module(mod_ginger_syslog).
-author("Driebit <tech@driebit.nl>").

-mod_title("Ginger Syslog").
-mod_description("Logs syslog formatted messages over UDP").
-mod_prio(500).

-export([
    init/1,
    pid_observe_zlog/3
]).

-include("zotonic.hrl").

init(Context) ->
    ginger_config:install_config(
        [
            {mod_ginger_syslog, host, "logstash"},
            {mod_ginger_syslog, port, 5514}
        ],
        Context
    ),
    Host = z_convert:to_list(m_config:get_value(mod_ginger_syslog, host, Context)),
    Port = z_convert:to_integer(m_config:get_value(mod_ginger_syslog, port, Context)),
    syslog:start_link(mod_ginger_syslog, Host, Port).

pid_observe_zlog(_Pid, #zlog{type=debug,props=#log_message{}}, _Context) ->
    undefined;
pid_observe_zlog(_Pid, #zlog{type=Type,props=#log_message{message=Message}}, _Context) ->
    syslog:send(mod_ginger_syslog, Message, [{level, Type}]);
pid_observe_zlog(_Pid, #zlog{}, _Context) ->
    undefined.

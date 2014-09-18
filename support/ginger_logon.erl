-module(ginger_logon).

-include_lib("include/zotonic.hrl").

-export([event/2]).

event(#submit{message={ginger_logon, Args}, form="logon_dialog"}, Context) ->
    LogonArgs = z_context:get_q_all(Context),
    Actions = proplists:get_all_values(action, Args),
    PageUrl = proplists:get_value(page, Args),
    case z_notifier:first(#logon_submit{query_args=LogonArgs}, Context) of
        {ok, UserId} when is_integer(UserId) ->
            ContextUser = logon_user(UserId, Actions, PageUrl, Context);
        {error, _Reason} -> 
            logon_error("pw", Context);
        undefined -> 
            ?zWarning("Auth module error: #logon_submit{} returned undefined.", Context),
            logon_error("pw", Context)
    end;

event(#postback{message={ginger_logoff, Args}}, Context) ->
    controller_logoff:reset_rememberme_cookie_and_logoff(Context),
    %Id = z_convert:to_integer(proplists:get_value(id, Args)),
    PageUrl = proplists:get_value(page, Args),
    z_render:wire({redirect, [{location, PageUrl}]}, Context).

logon_user(UserId, Actions, PageUrl, Context) ->
    case z_auth:logon(UserId, Context) of
		{ok, ContextUser} ->
		    case z_context:get_q("rememberme", ContextUser, []) of
		        [] -> ContextUser;
		        _ -> controller_logon:set_rememberme_cookie(UserId, ContextUser)
		    end,
            ?DEBUG(Actions),
            %Context1 = z_render:wire({redirect, [{location, cleanup_url(PageUrl)}]}, ContextUser),
            z_render:wire([
                {replace, [{target, "nav-logon"}, {template, "_nav_logon.tpl"}]} | Actions],
                ContextUser);
		%{error, user_not_enabled} ->
        %    check_verified(UserId, Context);
		{error, _Reason} ->
			% Could not log on, some error occured
			logon_error("unknown", Context)
	end.

logon_error(Reason, Context) ->
    ?DEBUG(Reason),
    Context1 = z_render:set_value("password", "", Context),
    Context2 = z_render:wire({add_class, [{target, "logon_box"}, {class, "logon_error"}]}, Context1),
    z_render:update("logon_error", z_template:render("_logon_error.tpl", [{reason, Reason}], Context2), Context2).


%% @doc Sign up a new user. Check if the identity is available.
ginger_signup(Props, SignupProps, Actions, PageUrl, Context) ->
    ?DEBUG(Props),
    ?DEBUG(SignupProps),
    case mod_signup:signup_existing(undefined, Props, SignupProps, false, Context) of
        {ok, NewUserId} ->
            ContextUser = logon_user(NewUserId, Actions, PageUrl, Context),
            z_render:growl("Registered new user", ContextUser);
        {error, {identity_in_use, username}} ->
            show_errors([error_duplicate_username], Context);
        {error, {identity_in_use, _}} ->
            show_errors([error_duplicate_identity], Context);
        {error, #context{} = ContextError} ->
            show_errors([error_signup], ContextError);
        {error, _Reason} ->
            show_errors([error_signup], Context)
    end.

show_errors(Errors, Context) ->
    Errors1 = [ z_convert:to_list(E) || E <- Errors ],
    z_render:wire({set_class, [{target,"signup_form"}, {class,Errors1}]}, Context).


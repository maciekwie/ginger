{% with btn_class|default:"btn--default" as btn_class %}

{% if id.action_rsvp %}
    {# Show an RSVP button, for events #}
        {% if m.acl.user %}
            {# If the user is logged in, show its RSVP status #}
            {% with m.acl.user.id, id as user, event %}

                {% if m.edge.id[user].participant[event]|is_defined %}
                    {# User has RSVPd #}
                    {% button
                        text=_"Afmelden"
                        class=rsvp-button
                        action={
                            unlink
                            subject_id=user
                            predicate="participant"
                            object_id=event
                            action={
                                redirect
                                id=event
                            }
                        }
                    %}
                {% else %}
                    {# User did not RSVP #}
                    {% button
                        text=_"Aanmelden"
                        class=rsvp-button
                        action={
                            link
                            subject_id=user
                            predicate="participant"
                            object_id=event
                            action={
                                redirect
                                id=event
                            }
                        }
                    %}
                {% endif %}
            {% endwith %}
        {% else %}
            {# The user is not logged in. Clicking on RSVP only logs in, nothing else. #}
            {% button
                text=_"Aanmelden"
                class=btn--default
                action={
                    dialog_open
                    title=_"logon or register"
                    template="_action_dialog_authenticate.tpl"
                    action={redirect id=id}
                    tab="logon"
                    id=id
                }
            %}
        {% endif %}
{% endif %}
{% endwith %}

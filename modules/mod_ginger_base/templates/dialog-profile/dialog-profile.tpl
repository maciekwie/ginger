{% if m.acl.user %}

    {% with m.rsc[m.acl.user] as user %}

        {% block logged_in_as %}
            <p class="dialog-profile__logged-in-as" >{_ Logged in as _}:</p>
        {% endblock %}

        {% block avatar %}
            <a class="dialog-profile__avatar" href="{{ user.page_url }}">
                {% include
                    "avatar/avatar.tpl"
                    id=m.rsc[m.acl.user]
                    fallback_rsc_id=m.rsc.custom_avatar_fallback.id
                %}
            </a>
        {% endblock %}

        {% block title %}
            <a class="dialog-profile__usertitle" href="{{ user.page_url }}">
                {{ user.title }}
            </a>
        {% endblock %}

        {% block log_off %}
            <div class="dialog-profile__log-off">
                <a href="{% url logoff %}">{{ logoff_label|if_undefined:_"Sign out" }} <i class="#"></i> </a>
            </div>
        {% endblock %}

    {% endwith %}

{% endif %}

<div class="page__content__metadata">

    {% if person %}
        {% if person.depiction %}
            <img class="page__content__metadata__depiction" src="{% image_url person.depiction mediaclass='img-avatar' %}" alt=""/>
        {% endif %}

        <p class="page__content__metadata__name">
            {{ role }}:<br/>
            <a href="{% url page id=person.id slug=person.slug %}">{{ person.title }}</a>
        </p>
    {% endif %}

    {% if links|is_defined and links|length > 0 %}
        <ul class="page__content__metadata__actions">
            {% for link in links %}
                <li>
                    {% if link[1] == 'Aanmelden' %}
                        {% include '_action_signup_event.tpl' %}
                    {% elif link[1] == 'Delen' %}
                        {% include '_action_share.tpl' %}
                    {% else %}
                        <a href="{{ link[2] }}" class="ginger-btn-pill--{{ link[3] }}">{{ link[1] }}</a>
                    {% endif %}
                </li>
            {% endfor %}
        </ul>
    {% endif %}

    {% if m.acl.user %}
        {% with m.acl.user as user %}
        {% with id.creator_id as creator %}
            {% if id.o.author.id == user.id or creator == user.id %}
                <a class="ginger-btn-pill--secondary" href="/edit/{{ m.rsc[id].id }}">{_ Bewerk _}</a>                
            {% endif %}
        {% endwith %}
        {% endwith %}
    {% endif %}
</div>
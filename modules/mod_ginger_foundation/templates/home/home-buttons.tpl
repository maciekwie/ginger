{% if id.o.relation %}
    {% for r in id.o.relation %}
        <a href="{{ r.page_url }}" class="home-button">{{ r.title }}</a>
    {% endfor %}
{% endif %}
{% extends "base.tpl" %}

{% block title %}Zoeken naar {{ q.qs }}{% endblock %}

{% block body_class %}search{% endblock %}

{% block content %}

    <div class="page__content-wrapper">
        <div class="search-results">
            <form class="search-results__form" role="search" action="{% url search %}" method="get">
                <input type="hidden" name="qsort" value="{{ q.qsort|escape }}" />
                <input type="hidden" name="qcat" value="{{ q.qcat|escape }}" />
                <input type="text" class="search-results__query" name="qs" value="{{q.qs|escape}}" autocomplete="off">
                <button type="submit" class="search-results__submit-btn">{_ Zoeken _}</button>
            </form>

            {% with m.search.paged[{query text=q.qs pagelen=10 page=q.page}] as result %}
                {% if result %}
                    {% pager result=result hide_single_page=1 gingerpager=true %}

                    {% include "_correlated-items.tpl" items=result showMetaData="date" title="" %}
                {% else %}
                    <p class="query-results__no-results">{_ Geen resultaten _}</p>
                {% endif %}
            {% endwith %}
        </div>
    </div>
{% endblock %}
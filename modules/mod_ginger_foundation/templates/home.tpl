{% extends "base.tpl" %}

{% block title %}{{ m.rsc.home.title }}{% endblock %}

{% block body_class %}t--home{% endblock %}

{% block content %}
{% with m.rsc.home.id as id %}
    {% include "masthead/masthead.tpl" id=id %}

    <main role="main">

        <div class="foldout">

            {% include "foldout/foldout-button.tpl" %}

            <div class="home__title">
                {% include "page-title/page-title.tpl" id=id %}

                {% include "subtitle/subtitle.tpl" id=id %}
            </div>

            <article class="main-content">

                {% include "summary/summary.tpl" id=id %}

                {% include "body/body.tpl" id=id %}
                
                {% include "home/home-buttons.tpl" id=id %}
            </article>

        </div>
        {% if id.o.haspart %}
            {% for r in id.o.haspart %}
                {% if r.o.haspart %}
                    {% with m.search[{query hassubject=[r.id,'haspart'] pagelen=3 }] as result %}

                        {% include "list/list-header.tpl" id=id list_title=r.title items=result %}

                        {% include "list/list.tpl" items=result id=id hide_button=1 %}

                    {% endwith %}
                {% else %}
                    {% with m.search[{query query_id=r pagelen=3 page=q.page sort='-rsc.pivot_date_start'}] as result %}

                        {% include "list/list-header.tpl" id=id list_title=r.title items=result %}

                        {% include "list/list.tpl" items=result id=id hide_button=1 %}

                    {% endwith %}
                {% endif %}
            {% endfor %}
        {% endif %}
    </main>
{% endwith %}
{% endblock %}
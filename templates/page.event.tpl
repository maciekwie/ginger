{% extends "base.tpl" %}

{% block title %}{{ id.title }}{% endblock %}

{% block body_class %}{% endblock %}

{% block content %}

    {% include "masthead/masthead.tpl" id=id %}

    <main role="main">

        <div class="foldout do_foldout">

            {% include "foldout/foldout-button.tpl" %}

            <article class="main-content">
                {% include "page-title/page-title.tpl" id=id %}

                {% include "subtitle/subtitle.tpl" id=id %}

                {% include "event/event-participants.tpl" limit=1 id=id %}

                {% catinclude "page-actions/page-actions.tpl" id %}

                {% include "summary/summary.tpl" id=id %}

                {% include "body/body.tpl" id=id %}

                {% include "blocks/blocks.tpl" id=id %}

                {% include "comments/comments.tpl" id=id %}
            </article>

        </div>
        {% if id.o.fixed_context %}
            <aside class="main-aside">
                {% with m.search[{query hassubject=[id,'fixed_context'] pagelen=6}] as result %}

                    {% include "list/list-header.tpl" id=id list_title=_"Gerelateerd" items=result %}

                    {% include "list/list.tpl" list_id="list--fixed-context" items=result extraClasses="" list_title=_"Gerelateerd" id=id %}

                {% endwith %}
            </aside>
        {% elif id.subject %}
            <aside class="main-aside">
                {% with m.search[{match_objects id=id pagelen=6}] as result %}
                    {% include "list/list-header.tpl" id=id list_title=_"Gerelateerd" items=result %}

                    {% include "keywords/keywords.tpl" id=id items=result %}

                    {% include "list/list.tpl" list_id="list--match-objects" items=result extraClasses="" list_title=_"Gerelateerd" id=id %}
                {% endwith %}
            </aside>
        {% endif %}
    </main>
{% endblock %}

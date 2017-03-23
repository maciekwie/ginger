{% extends "base.tpl" %}

{% block body_class %}t--article-sided{% endblock %}

{% block content %}
    <main role="main" class="page--sided">
        <div class="main-content--sided">
        <article>

            {% block published %}
                {% catinclude "published/published.tpl" id %}
            {% endblock %}

            {% block category_of %}
                {% catinclude "category-of/category-of.tpl" id class="category-of--sided" %}
            {% endblock %}

            {% include "page-title/page-title.tpl" id=id %}

            {% include "subtitle/subtitle.tpl" id=id %}

            {% block page_actions %}
                {% catinclude "page-actions/page-actions.tpl" id %}
            {% endblock %}

            {% include "summary/summary.tpl" id=id %}

            {% with id.media|without_embedded_media:id|first as dep %}
                {% catinclude "media/media.tpl" dep %}
            {% endwith %}

            {% include "body/body.tpl" id=id %}

            {% include "blocks/blocks.tpl" id=id %}

            {% block copyrights %}
                {% include "copyrights/copyrights.tpl" id=id %}
            {% endblock %}

            {% block attached_media %}
                {% include "attached-media/attached-media.tpl" id=id %}
            {% endblock %}

        </article>
        
        {% block comments %}
            {% include "comments/comments.tpl" id=id %}
        {% endblock %}
    </div>

        <aside class="main-aside--sided">
            {% include "part-of/part-of-aside.tpl" id=id %}

            {% include "about/about.tpl" id=id %}

            {% catinclude "main-aside/main-aside.tpl" id %}

        </aside>
    </main>
{% endblock %}

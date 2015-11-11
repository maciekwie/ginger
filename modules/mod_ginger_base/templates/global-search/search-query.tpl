{# Add one or more cat="NAME" to the query below to filter the result #}

{%
    with
        results_template,
        cat,
        paged|default:true,
        cat_exclude|default:['meta', 'menu', 'admin_content_query'],
        search_text|default:q.value|default:q.qs,
        cg_name,
        pagelen|default:10
    as
        results_template,
        cat,
        paged,
        cat_exclude,
        search_text,
        content_group,
        pagelen
%}
    {% if paged %}
        {% with m.search.paged[{query cat_exclude=cat_exclude content_group=content_group text=search_text pagelen=pagelen custompivot="ginger_findable" filter=["is_excluded_from_search", `=`, "f"]}] as result %}
            {% include results_template %}
        {% endwith %}
    {% else %}
        {% with m.search[{query cat_exclude=cat_exclude content_group=content_group text=search_text pagelen=pagelen page=q.page custompivot="ginger_findable" filter=["is_excluded_from_search", `=`, "f"]}] as result %}
            {% include results_template result=result %}
        {% endwith %}
    {% endif %}

{% endwith %}

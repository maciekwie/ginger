<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>{% block title %}{_ Admin _}{% endblock %} &mdash; {{ m.config.site.title.value|default:"Zotonic" }} Admin</title>
        
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="" />
        <meta name="author" content="Arjan Scherpenisse" />
        <link rel="icon" href="/lib/images/ginger.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="/lib/images/ginger.ico" type="image/x-icon" />

        {% lib
            "admin-bootstrap3/css/bootstrap.min.css"
        %}

        {% lib
                "css/jquery-ui.datepicker.css"
                "css/jquery.timepicker.css"
                "css/zp-menuedit.css"
                "css/zotonic-admin.css"
                "css/z.modal.css"
                "css/z.icons.css"
                "css/logon.css"
                "css/jquery.loadmask.css"
                "css/ginger-admin.css"
        %}

        {% all include "_html_head_admin.tpl" %}
        
        {% include "_js_include_jquery.tpl" %}
        <script src="//use.typekit.net/fym1ovy.js"></script>
        <script>try{Typekit.load();}catch(e){}</script>
        
        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        {% block head_extra %}
        {% endblock %}
    </head>
    <body class="{% block bodyclass %}{% endblock %} t-cms">

    {% wire name="adminwidget_toggle" action={adminwidget_toggle} %}

    {% block navigation %}
        {% include "_admin_menu.tpl" %}
    {% endblock %}

    <div class="admin-container">
        {% block content %}{% endblock %}
    </div>

    {% block logonfooter %}{% endblock %}

    {% include "_admin_js_include.tpl" %}
    {% block js_extra %}{% endblock %}

    {% script %}

    {% block editor %}{% endblock %}
        
    {% block html_body_admin %}{% all include "_html_body_admin.tpl" %}{% endblock %}

    {% block ua_probe %}
        {% include "_ua_probe.tpl"%}
    {% endblock %}
</body>
</html>
{% extends "base.tpl" %}

{% block title %} {{ error_code }} Error {% endblock %}

{% block content %}
<style type="text/css">
.errorpage {
  padding: 90px 30px 60px 30px;
  width: 1024px;
  box-sizing: border-box;
  margin: 0px auto;
}
@media screen and (max-width: 1023px) {
  .errorpage {
    width: 100%;
  }
}
</style>
<article class="errorpage">
{% if error_code == 403 %}
    <h1>{_ No Access _}</h1>
    <p>{_ Sorry, you don’t have access to this page. _}</p>
{% elseif error_code == 410 %}
  <h1>{_ Gone_}</h1>
  <p>{_ Sorry, this page has been deleted. _}</p>
{% elseif error_code == 404 %}
    {% if m.rsc.page_404.id as page_404 %}
        <h1 class="page-title">{{ page_404.title }}</h1>
        {% include "summary/summary.tpl" id=page_404 %}

        {% with page_404.media|without_embedded_media:page_404|first as dep %}
                {% catinclude "media/media.tpl" dep %}
            {% endwith %}

        {% include "body/body.tpl" id=page_404 %}

        {% include "blocks/blocks.tpl" id=page_404 %}
    {% else %}
        <h1>{_ That page does not exist _}</h1>
        <p><a href="/">{_ Return to the homepage _}</a></p>
    {% endif %}
{% else %}
    <h1>{{ error_code }} {_ error _}</h1>

    {% if error_erlang %}
        <p>{_ Reason _}: <strong>{{ error_erlang|escape }}</strong></p>
    {% endif %}

    {% if error_table %}
        <h2>{_ Stack trace _}</h2>

        <style type="text/css">
            table {
              background-color: transparent;
              border-collapse: collapse;
              border-spacing: 0;
            }

            .tablex {
              width: auto;
              margin-bottom: 18px;
            }
            .tablex th,
            .tablex td {
              padding: 8px;
              line-height: 18px;
              text-align: left;
              vertical-align: top;
              border-top: 1px solid #dddddd;
            }
            .tablex th {
              font-weight: bold;
              color: white;
            }
            .tablex thead th {
              vertical-align: bottom;
              background-color: #0778B0;
            }
            .table-striped tbody tr:nth-child(odd) td,
            .table-striped tbody tr:nth-child(odd) th {
              background-color: #f9f9f9;
            }
            .tablex tbody tr:hover td,
            .tablex tbody tr:hover th {
              background-color: #f5f5f5;
            }
            .template-error td {
                background-color: #fff9f9 !important;
            }
            .template-error td:nth-child(1),
            .template-error td:nth-child(2) {
                font-weight: bold;
            }
        </style>

        <table class="tablex table-striped" style="border-collapse: transparent; border-spacing: 0;">
            <thead>
                <tr>
                    <th align="left">{_ Module _}</th>
                    <th align="left">{_ Function/ template _}</th>
                    <th align="left">{_ Arguments _}</th>
                    <th align="left">{_ File _}</th>
                </tr>
            </thead>
            <tbody>
                {% for is_template,mod,func,arg,file in error_table %}
                    {% if is_template %}
                    <tr class="template-error">
                        <td>{{ mod|escape }}</td>
                        <td>{{ func|escape }}</td>
                        <td>{{ arg|escape }}</td>
                        <td>{{ file|escape}}</td>
                    </tr>
                    {% else %}
                    <tr>
                        <td>{{ mod|escape }}</td>
                        <td>{{ func|escape }}</td>
                        <td>{{ arg|escape }}</td>
                        <td>{{ file|escape}}</td>
                    </tr>
                    {% endif %}
                {% endfor %}
            </tbody>
        </table>
    {% else %}
        {% if error_dump %}
            <pre>{{ error_dump }}</pre>
        {% endif %}
    {% endif %}
{% endif %}
  </article>
{% endblock %}

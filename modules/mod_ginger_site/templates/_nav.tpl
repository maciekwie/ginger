<div class="row">
	<div class="col-xs-12">
		{% optional include "_nav_logon.tpl" button="small" %}
		{% optional include "_nav_edit.tpl" button="small" %}
	</div>
</div>

<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			{# <a class="navbar-brand" href="/">{{ m.config.site.title.value }}</a> #}
			<a class="navbar-brand" href="/">{_ Home _}</a>
		</div>

		<div class="collapse navbar-collapse" id="navbar-collapse">
			{% menu menu_id=menu_id id=id context=context %}
			{% include "_nav_language.tpl" context=context %}
			{% include "_search_form.tpl" context=context %}
		</div>
	</div>
</nav>
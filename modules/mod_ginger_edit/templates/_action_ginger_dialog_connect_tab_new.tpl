<div class="tab-pane {% if is_active %}active{% endif %}" id="{{ tab }}-new">
	{% include "_action_ginger_dialog_new_rsc_tab.tpl" 
        delegate="action_admin_dialog_new_rsc" 
        predicate=predicate
        callback=callback
        actions=actions
        cat=cat
        cg_id=cg_id
        nocatselect=nocatselect
        redirect=false
	%}
</div>

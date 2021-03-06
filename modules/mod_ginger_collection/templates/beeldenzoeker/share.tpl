 <div class="adlib-share">
    <button class="adlib-action__btn">{_ Share _}</button>
    <ul>
    	{% with
    		title|default:record['dcterms:title']|default:record.title|default:id.title,
    		url|default:m.collection_object.uri|default:m.site.hostname ++ id.page_url
    	as
    		title,
    		url
    	%}
	        <li><a href="http://www.facebook.com/sharer.php?u={{ url|urlencode }}&amp;t={{ title|urlencode }}" onclick="return !window.open(this.href, 'Facebook', 'width=600,height=500,toolbar=0,location=0,scrollbars=0,status=0')" title="Facebook" class="">{_ Facebook _}</a></li>
	        <li><a href="https://twitter.com/intent/tweet?text={{ title|urlencode  }}%20{{ url|urlencode }}&amp;t={{ title|urlencode }}" onclick="return !window.open(this.href, 'Twitter', 'width=600,height=300,location=0,toolbar=0,scrollbars=0,status=0')" title="Twitter" class="">{_ Twitter _}</a></li>
	        <li><a href="http://pinterest.com/pin/create/button/?url={{ url|urlencode }}&description={{ title|urlencode }}" target="_blank" title="Pinterest" class="">{_ Pinterest _}</a></li>
	        <li><a href="mailto:?subject={{ title|urlencode }}&amp;body={{ url|urlencode }}" title="{_ E-mail _}" class="">{_ E-mail _}</a></li>
	    {% endwith %}
    </ul>
</div>

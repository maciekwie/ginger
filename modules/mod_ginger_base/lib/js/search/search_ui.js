
$.widget("ui.search_ui", {

	_create: function() {
        
        var me = this;

        $(document).on('widgetmanager:loaded', $.proxy(me.init, this));

	},

	init: function() {

        //after all widget's _create function

		var me = this,
			inputSearch = $(document).find('.input-search'),
            queryString = $.url().param('searchterm');
	
		inputSearch.focus();
		
        $('.search__top__container').find('.btn--result-option').on('click', function() {
            $.proxy(me._toggleView($(this).attr('href').substring(1)), me);
            return false;
        });

        $('.global-search__submit').on('click', function(event){
            event.preventDefault();
            me.doSearch(true);
        });

        $(document).on('search:inputChanged', function() {
            me.doSearch(true);
        });

        me.searched = [];

        me._toggleView('list');

	},

    _toggleView: function(type){

        var me = this,
            type;

        $('.btn--result-option').removeClass('is-active');

        var buttonEl = $('[href="#' + type + '"]');

        buttonEl.addClass('is-active');
        $('.search__result__container').hide();
        $('#search-' + type ).show();
        $('#search-' + type ).css('visibility', 'visible'); 

        if (jQuery.inArray(type, me.searched) == -1) {
            me.doSearch();
        }

    },

	doSearch: function(reset) {

		var me = this,
			checkboxValue,
			inputfieldValue,
            type,
            widgetEls = $("[class*='do_search_cmp']"),
            widgetRefs = [],
            mergedValues = {};

        $.each(widgetEls, function(i, element){
            var classnames = element.className.split(/\s+/);
            $.each(classnames, function(j, classname) {
                if (classname.match(/do_search_cmp/)) {
                    var widgetName = classname.replace(/^do_/, '');
                    widgetRefs.push($(':ui-' + widgetName).data('ui-' + widgetName));                    
                } 
            });
        });

        $.each(widgetRefs, function(i, widget) {
            
            var widgetVals = widget.getValues();

            if (Array.isArray(widgetVals) ) {
                 $.each(widgetVals, function(j, val) {
                    if (mergedValues[val.type]) {
                        mergedValues[val.type] = mergedValues[val.type].concat(val.values);
                    } else {
                        mergedValues[val.type] = val.values;
                    }
                });
            }
        });

        type = me.getType();

        if (reset) me.searched = [];

		$(document).trigger("search:doSearch", {'values': mergedValues, 'type': me.getType() });

        if (jQuery.inArray(type, me.searched) == -1) me.searched.push(type);
	},


    getType: function() {
        var el = $('.btn--result-option.is-active');
        return (el.size() > 0) ? el.attr('href').replace(/#/, '') : false;
    }


});
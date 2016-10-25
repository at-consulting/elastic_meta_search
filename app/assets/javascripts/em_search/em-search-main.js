$(function(){
  $(".meta-search-link").emPopover({ placement: 'bottom'});

  var ac_input = $("#fs_term");
  if(ac_input.length){
    ac_input.autocomplete({
      minLength: 0,
      source: ac_input.data('source'),
      minLength: 3,
      select: function( event, ui ) {
        ac_input.val( ui.item.label );
        return false;
      }
    });

    ac_input.data("ui-autocomplete")._renderItem = function(ul, item) {
      var term = this.term.split(' ').join('|');
      var re = new RegExp("(" + term + ")", "gi");
      var t = item.label.replace(re,"<b>$1</b>");
      var infoSpanWidth = function(){
        var maxWidth = "";
        ul.find('li span.founded-parameter').each( function(el){
          if(maxWidth < el.attr('width'))
            maxWidth = el.attr('width')
        });
      };
      var renderContent = $("<a><span class='value'>" + t + "</span><span class='founded-parameter label label-info'>" + item.column + "</span></a>");
      return $("<li></li>")
         .addClass("ui-menu-item")
         .data("item.autocomplete", item)
         .append( renderContent )
         .appendTo(ul);
    };

    ac_input.data("ui-autocomplete")._resizeMenu = function() {
      var ul = this.menu.element;
      var valueWidthAry = [];
      var  infoWidthAry = [];
      ul.find("li").each(function(){
        valueWidthAry.push($(this).find("span.value").width());
        infoWidthAry.push($(this).find("span.founded-parameter").outerWidth(true));
      });
      var liA = ul.find("li a").first();
      ul.width( Math.max(
        (Math.max.apply(null, valueWidthAry) + Math.max.apply(null, infoWidthAry) + liA.outerWidth(true) - liA.width() + 1),
        this.element.outerWidth()
      ) );
      ul.find("li span.founded-parameter").each(function(){
        $(this).outerWidth(Math.max.apply(null, infoWidthAry))
      });
    };

    ac_input.data("ui-autocomplete")._suggest = function( items ) {
      var ul = this.menu.element
        .empty()
        .zIndex( this.element.zIndex() + 1 )
        .outerWidth(""); // that was added
      this._renderMenu( ul, items );

      ul.show();
      this._resizeMenu();
      ul.position( $.extend({
        of: this.element
      }, this.options.position ));

      if ( this.options.autoFocus ) {
        this.menu.next( new $.Event("mouseover") );
      }
    }
  }
});

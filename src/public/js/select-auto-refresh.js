(function( $ ){

  function updateQueryStringParameter(uri, key, value) {
    var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    var separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
      return uri.replace(re, '$1' + key + "=" + value + '$2');
    }
    else {
      return uri + separator + key + "=" + value;
    }
  }

  $(document).ready( function(){

    $(document).on("change" , ".select-auto-refresh" , function(){
        var name = $(this).attr("name");
        var val  = $(this).val();
        var url = updateQueryStringParameter( window.location.href , name , val );
        window.location.href = url;
    });

  });

})( jQuery );

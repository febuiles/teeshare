jQuery(document).ready(function($){
    $(".suggested-shirt").mouseenter(function(e){
        var _this = $(this);
        var imageURL = $("img", _this).attr("src");
        if (_this.children("div.tooltip").length == 0) {
            var div = $("<div class='tooltip'>");
            var img = $("<img src='" + imageURL +"' />");
            div.append(img);
            _this.append(div);
        }
    });
    $(".suggested-shirt").mouseleave(function(e){
        $(this).children("div.tooltip").remove();
    });

    $(".page_navigation a").live("click", function(){
      $("html, body").animate({ scrollTop: 0 }, "slow");
      return false;
    });
});
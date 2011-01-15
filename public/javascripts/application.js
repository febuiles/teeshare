jQuery(document).ready(function($){
    $(".suggested-shirt").mouseenter(function(e){
        $this = $(this);
        var imageURL = $("img", $this).attr("src");
        if ($this.children("div.tooltip").length == 0) {
            var div = $("<div class='tooltip'>");
            var img = $("<img src='" + imageURL +"' />");
            div.append(img);
            $this.append(div);
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
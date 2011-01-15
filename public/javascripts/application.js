$(document).ready(function(){
    $(".suggested-shirt").mouseenter(function(e){
        var imageURL = $(this).children("a").children("img").attr("src");
        if ($(this).children("div.tooltip").length == 0) {
            var div = $("<div class='tooltip right'>");
            var img = $("<img src='" + imageURL +"' />");
            div.append(img);
            $(this).append(div);
        }
    });
    $(".suggested-shirt").mouseleave(function(e){
        $(this).children("div.tooltip").remove();
    });
});
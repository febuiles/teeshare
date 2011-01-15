$(document).ready(function(){
    $(".suggested-shirt").mouseenter(function(e){
        var imageURL = $(this).children("a").children("img").attr("src");
        if ($(this).children("div.tooltip").length == 0) {
            $("<div class='tooltip right' style=\"background-image: url(" + imageURL + ");\">").appendTo($(this));
        }
    });
    $(".suggested-shirt").mouseleave(function(e){
        $(this).children("div.tooltip").remove();
    });
});
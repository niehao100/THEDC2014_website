#var indeximage;
#indeximage = document.getElementByClass('index-image');
$(document).ready ->
        if ($('.index-image').length == 0)
                $('body').css( 'margin-top', '30px')

$(function () {
    $('.header-menus li').hover(function () {
        $(this).css('font-weight', 'bold');
        $(this).css({
            transform: 'rotate(24deg)'
        });
    }, function () {
        $(this).css('font-weight', 'normal');
        $(this).css({
            transform: 'rotate(0)'
        });

    });
})
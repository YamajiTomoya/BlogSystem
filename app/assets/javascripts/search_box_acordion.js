$(function () {
    var nbsp = String.fromCharCode(160);
    $('.search-header').on('click', function () {
        if ($('.search-item').hasClass('open')) {
            $('.search-item').removeClass('open');
            $('.search-item').slideUp();
            $(this).find('h4').text('+' + nbsp + '検索' + nbsp + '+');
        } else {
            $('.search-item').addClass('open');
            $('.search-item').slideDown();
            $(this).find('h4').text('-' + nbsp + '検索' + nbsp + '-');
        }
    });
});
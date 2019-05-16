$(function () {
    var nbsp = String.fromCharCode(160);
    var $search_header = $('.search-header');
    var $search_item = $('.search-item')
    var $search_text = $search_header.find('h4')

    $search_header.on('click', function () {
        if ($search_item.hasClass('open')) {
            $search_item.removeClass('open');
            $search_item.slideUp();
            $search_text.text('+' + nbsp + '検索' + nbsp + '+');
        } else {
            $search_item.addClass('open');
            $search_item.slideDown();
            $search_text.text('-' + nbsp + '検索' + nbsp + '-');
        }
    });
});
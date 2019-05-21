$(function () {
    $search_form = $('.search-form');
    $search_button = $('#search-submit');
    $clear_button = $('#clear-button');

    // フォームへの入力を検知して、検索ボタンをクリック
    $search_form.on('keyup change', function () {
        $search_button.click();
    })

    // フォームを一度空にして、検索ボタンをクリック
    $clear_button.on('click', function () {
        $(".search-form").val("");
        $search_button.click();
    });
});
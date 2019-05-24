$(function () {
    $forms = $('.search-form').find('input');
    $clear_button = $('#clear-button');

    // ransackにまとめて検索項目を渡す
    search_params = {
        'q': {}
    }

    // ransackに渡すパラメータの更新
    function renew_search_params() {
        for (let index = 0; index < $forms.length; index++) {
            const element = $forms.eq(index);
            const key = element.attr('id').slice(2); // q_以降を抜き出す
            const value = element.val();
            search_params['q'][key] = value;
        }
    }

    ajaxPost = function (search_params) {
        $.ajax({
            url: location.href,
            type: 'GET',
            data: search_params
        });
    };

    // フォームへの入力を検知して、パラメータを更新。ajaxに渡す
    $forms.on('keyup change', function () {
        renew_search_params();
        ajaxPost(search_params);
    })

    // フォームを空にして、パラメータ更新。ajaxに渡す
    $clear_button.on('click', function () {
        $forms.val('');
        renew_search_params();
        ajaxPost(search_params);
    });
});
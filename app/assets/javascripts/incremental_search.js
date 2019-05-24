$(function () {
    $search_form = $('.search-form')
    $search_fields = $search_form.find('input').filter('[type = search]');
    $check_boxes = $search_form.find('input').filter('[type=checkbox]');
    $clear_button = $('#clear-button');

    // ransackにまとめて検索項目を渡す
    search_params = {
        'q': {}
    }

    // ransackに渡すパラメータの更新
    function update_search_params() {
        for (let index = 0; index < $search_fields.length; index++) {
            const element = $search_fields.eq(index);
            const key = element.attr('id').slice(2); // q_以降を抜き出す
            value = element.val();
            search_params['q'][key] = value;
        }

        status_eq_any = [] // statusをor検索するパラメーターを作る
        for (let index = 0; index < $check_boxes.length; index++) {
            const element = $check_boxes.eq(index);
            if (element.is(':checked')) {
                status_eq_any.push(element.val());
            }
        }
        search_params['q']['status_eq_any'] = status_eq_any;
    }

    ajaxPost = function (search_params) {
        $.ajax({
            url: location.href,
            type: 'GET',
            data: search_params
        });
    };

    // フォームへの入力を検知して、パラメータを更新。ajaxに渡す
    $search_form.on('keyup change', function () {
        update_search_params();
        ajaxPost(search_params);
        console.log(search_params);
    })

    // フォームを空にして、パラメータ更新。ajaxに渡す
    $clear_button.on('click', function () {
        $search_fields.val('');
        $check_boxes.prop('checked', false);
        update_search_params();
        ajaxPost(search_params);
    });
});
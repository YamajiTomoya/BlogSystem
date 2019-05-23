$(function () {
    $datepicker = $('.datepicker');
    $status_radio_buttons = $("[name = 'article[status]']");

    $datepicker.datetimepicker({
        format: 'YYYY-MM-DD HH:mm',
        minDate: new Date(),
    });

    // 予約投稿ボタンが押された時にのみdate_time_pickerを使えるようにする
    $status_radio_buttons.click(function () {
        var value = $("[name = 'article[status]']:checked").val();
        if (value == 'reserved') {
            $datepicker.attr('disabled', false);
        } else {
            $datepicker.val('');
            $datepicker.attr('disabled', true);
        }
    });
});
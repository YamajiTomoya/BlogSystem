$(function () {
    $("#clear-form").on("click", function () {
        $("#q_title_cont, #q_created_at_gteq, #q_created_at_lteq").val("");
    });
});
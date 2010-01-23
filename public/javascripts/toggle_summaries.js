$(function() {
  $("#summaries_control").click(function() {
    $("#summaries").toggle();
    var url = $("a:contains('My Account')").attr("href").replace(/.edit$/, '');
    var show_summaries = $("#summaries").is(":visible");
    $.post(url, { "user[show_summaries]" : (show_summaries ? "1" : "0"), "_method" : "PUT" });
  });
});

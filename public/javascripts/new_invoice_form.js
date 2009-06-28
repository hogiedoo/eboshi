$(function() {
  $("table input:checkbox").click(function() {
    var total = 0.0;
    $("table input:checked").each(function() {
      total += parseFloat($(this).closest("tr").find("td[data-total]").attr("data-total"));
    });
    $("#invoice_total").val(total);
  });
});

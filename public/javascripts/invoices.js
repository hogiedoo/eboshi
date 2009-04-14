$(function() {
  $("tr.line_item").live('mouseover', function() {
    $(this).addClass("line_item_over")
  })

  $("tr.line_item").live('mouseout', function() {
    $(this).removeClass("line_item_over")
  })

  $("tr.line_item").live('click', function(e) {
    if(e.target.type == 'textarea') return
    $(this).toggleClass("line_item_selected")
    if(!$(e.target).is(":checkbox")) $(this).find(":checkbox").toggleChecks()
  })
  
  $("a#create_invoice").click(function() {
    var line_items = $(this).parents("tbody").find(":checkbox:checked").serialize()
    location.href = this.href+"?"+line_items
    return false
  })

  $("form:has(#clock_in)").POST(function(data) {
    $("#new_line_items").after(data)
  })

  $("a.clock_out").POST(function(data) {
    this.parents("tr").replaceWith(data.work)
    this.parents("tbody").find("td.total").text(number_to_currency(data.total))
  }, "json")

  $("a.delete").live('click', function() {
    var a = this
    if(confirm('Are you sure you want to delete this line item?')) {
      $.post(a.href, '_method=delete', function(data) {
        $(a).parents("table").find("thead td.total").text(number_to_currency(data))
        $(a).parents("tr").remove()
      }, 'json')
    }
    return false
  })
  
  $("a#merge").click(function() {
    var checkboxes = $(this).parents("table").find(":checkbox:checked")
    if(checkboxes.length > 0) {
      $.post(this.href, checkboxes.serialize(), function(data) {
        $(checkboxes[0]).parents("tr").replaceWith(data)
        checkboxes.slice(1).parents("tr").remove()
      })
    }
    return false
  })

  $("a.mini_invoice_show_details").GET(function(data) {
    this.parents("div:first").replaceWith(data)
  })

  $("a.invoice_hide_details").GET(function(data) {
    this.parents("table:first").replaceWith(data)
  })
})

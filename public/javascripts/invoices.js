jQuery.fn.POST = function(callback, type) {
  return jQueryGETorPOST.call(this, "POST", callback, type)
}

jQuery.fn.GET = function(callback, type) {
  return jQueryGETorPOST.call(this, "GET", callback, type)
}

function jQueryGETorPOST(method, callback, type) {
  method = (method == "GET" ? $.get : $.post)
  if(!type) type = "html"
  var event = this.is("form") ? "submit" : "click"
  this.livequery(event, function() {
    var el = $(this)
    var url = el.is("form") ? el.attr("action") : el.attr("href")
    var params = el.is("form") ? el.serialize() : null
    method(url, params, function(data, textStatus) { callback.call(el, data, textStatus) }, type)
    return false
  })
  return this
  
}

$(function() {
  $("form:has(#clock_in)").POST(function(data) {
    $("#new_line_items").after(data)
  })

  $("a.clock_out").POST(function(data) {
    this.parents("tr").replaceWith(data.line_item)
    this.parents("tbody").find("td.total").text(number_to_currency(data.total))
  }, "json")

  $("form:has(input.delete)").livequery('click', function() {
    var form = $(this)
    if(confirm('Are you sure you want to delete this line item?')) {
      $.post(form.attr("action"), form.serialize(), function(data) {
        form.parents("tbody").find("td.total").text(number_to_currency(data))
        form.parents("tr").remove()
      }, 'json')
    }
    return false
  })
  
  $("a.merge").click(function() {
    var checkboxes = $(this).parents("table").find(":checkbox:checked")
    if(checkboxes.length > 0) {
      $.post(this.href, checkboxes.serialize(), function(data) {
        $(checkboxes[0]).parents("tr").replaceWith(data)
        checkboxes.slice(1).parents("tr").remove()
      })
    }
    return false
  })

  $("a#show_paid_invoices").click(function() {
    var el = $("#paid_invoices")
    if(el.is(":empty")) {
      el.hide()
      $.get(this.href, '', function(data) {
        el.html(data)
        el.slideDown("normal")
      }, 'html')
    } else {
      el.slideToggle("normal")
    }
    return false
  })

  $("a.mini_invoice_show_details").GET(function(data) {
    this.parents("div:first").replaceWith(data)
  })

})

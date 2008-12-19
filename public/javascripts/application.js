// jQuery extensions //////////////////////////////////////////////////////////

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

// Ajax shorthand

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

// Checkbox toggle

jQuery.fn.toggleChecks = function(bool) {
  if(!$(this).is(":checkbox")) return false
  $(this).attr("checked", !$(this).attr("checked"))
}

// Misc ///////////////////////////////////////////////////////////////////////

Date.prototype.toSQL = function() {
  return this.getFullYear() + '-' +
    (this.getMonth() + 1).toPaddedString(2) + '-' +
    this.getDate().toPaddedString(2) + ' ' +
    this.getHours().toPaddedString(2) + ':' +
    this.getMinutes().toPaddedString(2) + ':' +
    this.getSeconds().toPaddedString(2);
};

function number_to_currency(number, options) {
  try {
    var options   = options || {};
    var precision = options["precision"] || 2;
    var unit      = options["unit"] || "$";
    var separator = precision > 0 ? options["separator"] || "." : "";
    var delimiter = options["delimiter"] || ",";
 
    var parts = parseFloat(number).toFixed(precision).split('.');
    return unit + number_with_delimiter(parts[0], delimiter) + separator + parts[1].toString();
  } catch(e) {
    return number
  }
}

function number_with_delimiter(number, delimiter, separator) {
  try {
    var delimiter = delimiter || ",";
    var separator = separator || ".";
    
    var parts = number.toString().split('.');
    parts[0] = parts[0].replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1" + delimiter);
    return parts.join(separator);
  } catch(e) {
    return number
  }
}

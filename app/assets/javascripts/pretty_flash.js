function show_flash_notice() {
  $("#flash_notice").fadeIn()
  window.setTimeout("hide_flash_notice()", 5000);
}
function hide_flash_notice() {
  $("#flash_notice").fadeOut()
}

function show_flash_error() {
  $("#flash_error").fadeIn()
  window.setTimeout("hide_flash_error()", 5000);
}
function hide_flash_error() {
  $("#flash_error").fadeOut()
}
 
$(function() {
  if($('#flash_error')[0].innerHTML != '') show_flash_error()
  /* if($('#flash_notice')[0].innerHTML != '') show_flash_notice() */
});

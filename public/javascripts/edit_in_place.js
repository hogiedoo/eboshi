$(function() {
  $("td.notes textarea").livequery(function() {
    this.buffer = this.value
    this.wait = false
    // grab line_item id from tr
    this.line_item_id = this.id.match(/notes_([0-9]+)/)[1]

    this.delayedSend = function() {
      // ignore non destructive keypresses
      if(this.buffer == this.value) return
      
      // send updates out every two seconds
      if(this.wait) {
        window.setTimeout('\
          $("textarea#notes_'+this.line_item_id+'")[0].wait = false;\
          $("textarea#notes_'+this.line_item_id+'")[0].delayedSend();\
        ', 500)
      } else {
        this.buffer = this.value
        $.post('/line_items/'+this.line_item_id, '_method=put&line_item[notes]='+escape(this.value))
        this.wait = true
      }
    }
    
    $(this).keyup(this.delayedSend)
  })
})

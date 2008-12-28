$(function() {
  $("td.notes textarea").livequery(function() {
    new AutoResizeTextArea.init(this)
  })
})

var AutoResizeTextArea = {
  init: function(el) {
    // get height of the element; use as minimum
    var originalHeight = el.offsetHeight;  
      
    // adjust the textarea, for all good browsers: overflow:hidden to lose the scrollbars,   
    // for IE use overflowX:auto to let that browser decide whether to show scrollbars  
    $(el).css("overflow", "hidden")
    $(el).css("overflowX", "auto")
      
    // create a new element that will be used to track the dimensions  
    var dummy_id = Math.floor(Math.random()*99999) + '_dummy';  
    var dummy = document.createElement('div');  
    document.body.appendChild(dummy);  
  
    // hide the created div away  
    dummy.style.position = 'absolute';  
    dummy.style.top = '0px';  
    dummy.style.left = '-99999px';  
    dummy.innerHTML = ' 42';  
      
    var lineHeight = dummy.offsetHeight;  
      
    var checkExpandContract = function() {  
      // place text inside the element in a new var called html  
      $.each(['display', 'font-family', 'font-weight', 'font-size', 'padding', 'margin', 'overflow-x'], function() {
        $(dummy).css(this, $(el).css(this))
      })
      
      // hack width to fix, 2px too big for some god damned reason
      var width = $(el).css('width')
      if(width.charAt(width.length-1) == "x") {  
        width = parseInt(width.substring(0,width.length-2))   
      }
      $(dummy).css('width', width-2+"px")

      // transfer content to dummy      
      var html = el.value.replace(/\n/g, '<br>');  
      if(dummy.innerHTML != html) {  
        dummy.innerHTML = html;  
          
        // skip if the height from our element matches the dummy height
        if (el.offsetHeight != dummy.offsetHeight) {
          // ensure minimum height
          if (dummy.offsetHeight < originalHeight) {
            el.style.height = originalHeight+'px';
          } else {
            el.style.height = (dummy.offsetHeight + lineHeight) + 'px';
          }
        }
      }
    }
    
    // Startup
    var expandElement = function()  {
        interval = window.setInterval(function() {checkExpandContract()}, 250);
    }
    
    var contractElement = function() {
        clearInterval(interval);
    }
    
    // Put eventListeners to our elements
    $(el).focus(expandElement);
    $(el).blur(contractElement);
    checkExpandContract();
  }
}

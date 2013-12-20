$ ->
  $('#errors').hide() if $('#errors').text() is ""
  $('#notices').hide() if $('#notices').text() is ""
    
  $('.notice_section').delay(4000).slideUp(1000)

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
jQuery ->
  $('.rtable').button()
  $('.button').button()
  $('#accordion').accordion
    autoheight: false,
    navigation: true
  $('.selectable').selectable filter: 'tr'
  $('#categories').change -> 
    $('.catprod:visible').hide()
    s = $(@).find('option:selected').val()
    #console.log s
    $("#cp" + s).show()
  $('.rtable').click ->
    $('#accordion').accordion('activate',1)
    if $(@).hasClass('occupied')
      t_id = $(@).attr('id').split(/ticket-/)
      $('.billbox table:visible').hide()
      $('#rt' + t_id[1]).show()
    else
      valarr = $(@).attr('id').match(/\d+/)
      $('#ticket_r_table_id').val('' + valarr[0])
      $.rails.handleRemote($('#new_ticket'))
      ''

  $('.product').click ->
    $('#ticket_line_ticket_id').val($('.billbox table:visible').attr('id').match(/\d+/)[0])
    $('#ticket_line_product_id').val($(@).attr('id').match(/\d+/)[0])
    $('#ticket_line_qty').val(1)
    $.rails.handleRemote($('#new_ticket_line'))
  ''    
      

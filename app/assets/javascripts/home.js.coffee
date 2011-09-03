# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
jQuery ->
  $('.rtable').button()
  $('.button').button()
  $('#accordion').accordion
    autoheight: false,
    event: false
  $('.billbox table').selectable 
    filter: 'tr'
  $('#categories').change -> 
    $('.catprod:visible').hide()
    s = $(@).find('option:selected').val()
    $("#cp" + s).show()
  $('.rtable').click ->
    $('#accordion').accordion('activate',1)
    if $(@).hasClass('occupied')
      t_id = $(@).attr('id').split(/ticket-/)
      $('.ticket:visible').hide()
      $('#rt' + t_id[1]).show()
      $('#void_form').attr('action','/tickets/' + t_id[1])
      $('.billview a').html('Bill - ' + $(@).text())
    else
      valarr = $(@).attr('id').match(/\d+/)
      $('#ticket_r_table_id').val('' + valarr[0])
      $.rails.handleRemote($('#new_ticket'))
    $('#search').focus()
    $('.ticket:visible .billbox table tr:last').addClass('ui-selected')
    ''

  $('.product').click ->
    $('#ticket_line_ticket_id').val($('.ticket:visible').attr('id').match(/\d+/)[0])
    $('#code').val($(@).attr('id').match(/\d+/)[0])
    $('#ticket_line_qty').val(1)
    $.rails.handleRemote($('#new_ticket_line'))

  $('#void_dialog').dialog
    autoOpen: false,
    width: 450,
    buttons: 
      "Submit": ->
        $(this).dialog("close") 
        $.rails.handleRemote($('#void_form'))
      , 
      "Cancel": ->
        $(this).dialog("close")
       
  $('#void').click ->   
    $('#ticket_status').val('void')
    $('#void_dialog').dialog 'open'
  $('#accordion h3:first').click -> 
    $('#accordion').accordion('activate',0)
  $('.billview').click -> 
    $('#accordion').accordion('activate',0)
  ''    
  updateTicketLines = ->
    $('#ticket_line_ids').val('')
    $.each $('.ui-selected'), (i,val) ->
      $('#ticket_line_ids').val($('#ticket_line_ids').val() + $(val).attr('id').match(/\d+/)[0] + ',')
    $.rails.handleRemote($('#update_ticket_lines')) if $('.ui-selected').length > 0
  $('#addItem').click ->
    $('#action_for_ticket').val('add')
    updateTicketLines()
  $('#subItem').click ->
    $('#action_for_ticket').val('sub')
    updateTicketLines()
  $('#delItem').click ->
    $('#action_for_ticket').val('del')
    updateTicketLines()
  $(document).keypress (e) ->
    e.preventDefault() if e.which == 13
    if $('#addItem').is(':visible')
      if e.which == 43 
        $('#action_for_ticket').val('add')
        $('#search').val('')
        $('#addItem').focus()
        updateTicketLines()
      else if e.which == 45 
        $('#action_for_ticket').val('sub')
        $('#search').val('')
        $('#subItem').focus()
        updateTicketLines()


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
jQuery ->
  checkpayment = -> 
    if parseInt($('.payment:visible .total_pending').text()) != 0
      return false
    else
      return true
  $('#floors').tabs()
  $('.rtable').button()
  $('.bbutton').button()
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
      $('#update_ticket').attr('action','/tickets/' + t_id[1])
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
    modal: true,
    autoOpen: false,
    width: 450,
    buttons: 
      "Submit": ->
        $(this).dialog("close") 
        $.rails.handleRemote($('#update_ticket'))
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
  $('#pay_dialog').dialog
    modal: true,
    autoOpen: false,
    width: 450,
    buttons: 
      "Submit": ->
        if checkpayment()
          $('#ticket_status').val('closed')
          $.rails.handleRemote($('#update_ticket'))
          $(this).dialog("close") 
        else
          alert "Pending Payment must be zero"
      , 
      "Cancel": ->
        $(this).dialog("close")
       
  $('#pay').click ->   
    $('#payment_owner_id').val($('.ticket:visible').attr('id').match(/\d+/)[0])
    $('#payment_owner_type').val('Ticket')
    $('.payment').hide()
    $('#p-' + $('.ticket:visible').attr('id').match(/\d+/)[0]).show()
    $('#pay_dialog').dialog 'open'
    val = 0
    pay = parseInt($('.payment:visible .total_payments').text())
    tot = parseInt($('.ticket:visible .ticket_total').text())
    $('.payment:visible .total_pending').html(tot - pay)
    $('.payment:visible .total_amount').html(tot)
    if parseInt($('.payment:visible .total_pending').text()) != 0
      val = parseInt($('.payment:visible .total_pending').text())
    else
      val = tot - pay
    if $('#given_amount').is(':visible')
      amt = '#given_amount'
      $('#total_remaining').html(val)
      $('#change_amount').html(0)
      $('#amount_total').val(val)
    else
      amt = '#payment_amount'
      $('#amount_total').val(0)
    $(amt).val(val)
    $(amt).select()
    $(amt).focus()
  updateGiven = -> 
    $('#given_amount').val(parseInt($('.payment:visible .total_pending').text()))
    $('#total_remaining').html(0)
    $('#change_amount').html(0)
    $('#amount_total').val(parseInt($('.payment:visible .total_pending').text()))
  $('#payment_payment_method_id').change ->
    if $(@).find('option:selected').val() == "2"
      $('#other_amount').hide()
      $('#given_cash').show()
      updateGiven()
    else
      $('#given_cash').hide()
      $('#payment_amount').val(parseInt($('.payment:visible .total_pending').text()))
      $('#other_amount').show()
  $('#given_amount').change ->
    if parseInt($('.payment:visible .total_payments').text()) != 0
      tot = parseInt($('.ticket:visible .ticket_total').text()) - parseInt($('.payment:visible .total_payments').text())
      if tot == 0
        alert 'No need to add payment'
        return
    else
      tot = parseInt($('.ticket:visible .ticket_total').text())
    given = parseInt($('#given_amount').val())
    chg = given - tot
    $('#change_amount').html(chg)
    if given > tot
      $('#amount_total').val(tot)
      $('#total_remaining').html(0)
    else
      $('#amount_total').val(given)
      $('#total_remaining').html(tot - given)

  printTicket = -> 
    str = 'Item            Price   Qty   Value\n-------------------------------------\n';
    
    $('.ticket:visible table[class=ui-selectable] tr').each -> 
      item = $.trim($(this).find('td:first').text())
      price = $.trim($(this).find('td:nth-child(2)').text())
      if price.length == 3
       price = "0" + price + '    '
      else if price.length == 4
        price += '    '
      else
        price += '   '
      qty = $.trim($(this).find('td:nth-child(3)').text())
      itot = $.trim($(this).find('td:nth-child(4)').text())
      if item.length > 15
        item = item.substring(0,13) + '..'      
      else
        while item.length < 15
          item = item + ' '
      str += item + ' ' + price +  qty + '    ' + itot + '\n'
    subt = $.trim($('.ticket:visible .ticket_subtotal').text())
    tax = $.trim($('.ticket:visible .ticket_tax').text())
    d = $.trim($('.ticket:visible .ticket_discount').text())
    t = $.trim($('.ticket:visible .ticket_total').text())
    str += '-------------------------------------\n'
    str += '                    Subtotal: ' + subt + '\n'
    str += '                    Discount: ' + d + '\n'
    str += '                         Tax: ' + tax + '\n'
    str += '                       Total: ' + t + '\n'
    str = $.trim($('#ticketheader .name').text()) + '\n' + $.trim($('#ticketheader .add1').text()) + '\n' + $.trim($('#ticketheader .add2').text()) + '\n' + $.trim($('#ticketheader .add3').text()) + '\n' + $.trim($('#ticketheader .web').text()) + '\n'  + $.trim($('#ticketheader .phone').text()) + '\n\n' + str
    str += '\n-------------------------------------\n'
    str += $.trim($('#ticketfooter').text()) + "\n\n\n\n"
    str

  $('#print').click -> 
    str = printTicket()
    jPrint(str)
    console.log(str)
  monitorPrinting = -> 
    applet = document.jZebra;
    if applet != null 
      if (!applet.isDonePrinting()) 
        window.setTimeout('monitorPrinting()', 100)
      else 
        e = applet.getException();
        alert(e == null ? "Printed Successfully" : "Exception occured: " + e.getLocalizedMessage())
    else 
      alert("Applet not loaded!");
      
    
  chr = (str) -> 
    String.fromCharCode(str)
  jPrint = (str) -> 
    applet = document.jZebra
    if applet != null
      #applet.append(chr(27) + "\x61" + "\x31");
      applet.append(str)
      applet.print()
      monitorPrinting()
      applet.append(chr(27) + chr(105));
      applet.print()
    else 
      alert "applet not loaded"


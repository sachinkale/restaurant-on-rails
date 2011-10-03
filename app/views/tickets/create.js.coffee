jQuery ->
  <% if @ticket %>
    $('#t<%= @ticket.r_table_id %>').addClass('occupied')
    $('#t<%= @ticket.r_table_id %>').removeClass('notoccupied')
    $('#t<%= @ticket.r_table_id %>').attr('id', "t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>")
    $('.ticket:visible').hide()
    $('.tickets').append("<%= escape_javascript(render :partial => "tickets/ticket", :locals => {:ticket => @ticket }) %>")
    $('#rt<%= @ticket.id %>').show()
    $('#update_ticket').attr('action', '/tickets/<%= @ticket.id %>')
    $('#payments_holder').append("<%= escape_javascript(render :partial => "payments/payments", :locals => {:ticket => @ticket } ) %>")
    $('.billview a').html('Bill - ' + $("#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>").text())
    $('.billbox table').selectable filter: 'tr'
    $(".occupied").draggable({ opacity: 0.7, helper: "clone" });
    $(".notoccupied").droppable ->
      accept: '.occupied',
      activeClass: "ui-state-hover",
      hoverClass: "ui-state-active",
      drop: (event,ui) ->
        t = ui.draggable.attr('id').split(/ticket-/)
        $('#change_table_ticket_id').val(t[1])
        $('#change_table_orig_table_id').val(t[0].match(/\d+/)[0])
        $('#change_table_table_id').val($(this).attr('id').match(/\d+/)[0])
        $.rails.handleRemote($('#change_table'))

  <% else %>
    alert "Ticket Present <%= @ticket_present.id.to_s %>"
  <% end %>


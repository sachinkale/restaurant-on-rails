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
  <% else %>
    alert "Ticket Present <%= @ticket_present.id.to_s %>"
  <% end %>


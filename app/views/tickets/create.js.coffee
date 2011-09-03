jQuery ->
  <% if @ticket %>
    $('#t<%= @ticket.r_table_id %>').addClass('occupied')
    $('#t<%= @ticket.r_table_id %>').attr('id', "t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>")
    $('.ticket:visible').hide()
    $('.tickets').append("<%= escape_javascript(render :partial => "tickets/ticket", :locals => {:ticket => @ticket }) %>")
    $('#rt<%= @ticket.id %>').show()
    $('#void_form').attr('action', '/tickets/<%= @ticket.id %>')
    $('.billview a').html('Bill - ' + $("#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>").text())
    $('.billbox table').selectable filter: 'tr'
  <% else %>
    alert "Ticket Present <%= @ticket_present.id.to_s %>"
  <% end %>


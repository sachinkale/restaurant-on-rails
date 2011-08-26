jQuery ->
  <% if @ticket %>
    $('#t' + <%= @ticket.r_table_id %>).addClass('occupied')
    $('#t' + <%= @ticket.r_table_id %>).attr('id', "<%= 't' + @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>")
    $('.billbox table:visible').hide()
    $('.billbox').append("<table id='rt<%= @ticket.id.to_s %>'></table>")
  <% else %>
    alert "Ticket Present <%= @ticket_present.id.to_s %>"
  <% end %>


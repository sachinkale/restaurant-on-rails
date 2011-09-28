<% if @error %>
  alert "Error while updating ticket"
<% else %>
  $('#rt<%= @ticket.id %>').remove()
  $('#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>').removeClass('occupied')
  $('#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>').addClass('notoccupied')
  $('#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>').attr('id', 't<%= @ticket.r_table_id %>')
  $('#accordion').accordion('activate',0)
  $('.billview a').html('Bill')
<% end %>

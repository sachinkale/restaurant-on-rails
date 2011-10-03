jQuery ->
  <% if @error %>
  alert "Error while updating ticket"
  <% else %>
  $('#rt' + <%= @ticket.id %>  + ' .ticket_discount').html(<%= @ticket.get_discount %>)
  $('#rt' + <%= @ticket.id %>  + ' .ticket_total').html(<%= @ticket.total %>)
  <% end %>



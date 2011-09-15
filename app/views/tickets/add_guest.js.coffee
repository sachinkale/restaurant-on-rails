jQuery ->
  <% if @error %>
  alert "Error while updating ticket"
  <% else %>
  $('.ticket:visible .customername').html('<%= @ticket.guest.FirstName + ' ' + @ticket.guest.LastName %>')
  <% end %>


jQuery ->
  <% if @error %>
  alert "Cannot delete!"
  <% else %>
  $('.payment:visible tr[id=Payment-<%= params[:id] %>]').remove()
  $('.payment:visible .total_payments').html('<%= @total_payments %>')
  $('.payment:visible .total_pending').html('<%= @ticket.total - @total_payments %>')
  <% end %>

jQuery ->
  <% if @ticket_line %>
    $('.billbox table:visible').append('<tr><td><%= @ticket_line.product.name %></td><td><%= @ticket_line.product.sell_price %></td><td>x<%= @ticket_line.qty %></td><td><%= @ticket_line.product.sell_price * @ticket_line.qty %></td></tr>')
  <% else %>
    alert "Could not create entry"
  <% end %>

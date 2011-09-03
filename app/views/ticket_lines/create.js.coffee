jQuery ->
  <% if @ticket_line %>
    $('#rt' + <%= @ticket_line.ticket.id %>  + ' .billbox table').append('<tr class="ui-selectee" id="tl<%= @ticket_line.id %>"><td><%= @product.name %></td><td><%= @ticket_line.sell_price %></td><td>x<%= @ticket_line.qty %></td><td><%= @ticket_line.sell_price * @ticket_line.qty %></td></tr>')
    $('#rt' + <%= @ticket_line.ticket_id %>  + ' .ticket_subtotal').html(<%= @ticket_line.ticket.subtotal %>)
    $('#rt' + <%= @ticket_line.ticket_id %>  + ' .ticket_discount').html(<%= @ticket_line.ticket.discount %>)
    $('#rt' + <%= @ticket_line.ticket_id %>  + ' .ticket_tax').html(<%= @ticket_line.ticket.tax %>)
    $('#rt' + <%= @ticket_line.ticket_id %>  + ' .ticket_total').html(<%= @ticket_line.ticket.total %>)
    $('#rt' + <%= @ticket_line.ticket.id %>  + ' .billbox table .ui-selected').removeClass('ui-selected')
    $('#rt' + <%= @ticket_line.ticket.id %>  + ' .billbox table tr:last').addClass('ui-selected');

  <% else %>
    alert "Could not create entry"
  <% end %>

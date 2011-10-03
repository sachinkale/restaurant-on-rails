jQuery ->
  <% @deleted_items.each do |d| %>
  $('#tl<%= d %>').remove()
  <% end %>
  <% if params[:action_for_ticket] != "del" %>
  <% @ticket_lines.each do |t| %>
  $('#tl<%= t.id %> td:nth-child(3)').html('x<%= t.qty %>')
  $('#tl<%= t.id %> td:nth-child(4)').html('<%= t.qty * t.sell_price %>')
  <% end %>
  <% end %>
  
  $('#rt' + <%= @ticket.id %>  + ' .ticket_subtotal').html(<%= @ticket.subtotal %>)
  $('#rt' + <%= @ticket.id %>  + ' .ticket_discount').html(<%= @ticket.get_discount %>)
  $('#rt' + <%= @ticket.id %>  + ' .ticket_tax').html(<%= @ticket.tax %>)
  $('#rt' + <%= @ticket.id %>  + ' .ticket_total').html(<%= @ticket.total %>)
 

jQuery ->
  <%if @error %>
  alert '<%= @error %>'
  <% else %>
  <% str = link_to @payment, :method => 'delete', :remote => true do %> 
   <div class='ui-icon ui-icon-close'/> 
  <% end %>

  $('.payment:visible tr:first').after('<tr id="Payment-<%= @payment.id %>"><td><%= @payment.payment_method.name %></td><td><%= @payment.amount %></td><td>' +'<%= escape_javascript(str) %>' + '</td></tr>')
  $('.payment:visible .total_payments').html('<%= @total_payments %>')
  $('.payment:visible .total_pending').html('<%= @ticket.total - @total_payments %>')
  $('#given_amount').val(parseInt($('.payment:visible .total_pending').text()))
  $('#total_remaining').html(0)
  $('#change_amount').html(0)
  $('#amount_total').val(parseInt($('.payment:visible .total_pending').text()))

  <% end %>

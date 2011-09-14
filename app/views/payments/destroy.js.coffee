jQuery ->
  <% if @error %>
  alert '<%= @error %>'
  <% else %>
  $('.payment:visible tr[id=Payment-<%= params[:id] %>]').remove()
  $('.payment:visible .total_payments').html('<%= @total_payments %>')
  $('.payment:visible .total_pending').html('<%= @ticket.total - @total_payments %>')
  $('#given_amount').val(parseInt($('.payment:visible .total_pending').text()))
  $('#total_remaining').html(0)
  $('#change_amount').html(0)
  $('#amount_total').val(parseInt($('.payment:visible .total_pending').text()))

  <% end %>

<% if @error %>
  alert "Error while updating ticket"
<% else %>
  $('#rt<%= @ticket.id %>').remove()
  $('#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>').removeClass('occupied')
  $('#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>').addClass('notoccupied')
  $('#t<%= @ticket.r_table_id.to_s + '-ticket-' + @ticket.id.to_s %>').attr('id', 't<%= @ticket.r_table_id %>')
  $('#accordion').accordion('activate',0)
  $('.billview a').html('Bill')
  $(".occupied").draggable({ opacity: 0.7, helper: "clone" });
  $(".notoccupied").droppable ->
    accept: '.occupied',
    activeClass: "ui-state-hover",
    hoverClass: "ui-state-active",
    drop: (event,ui) ->
      t = ui.draggable.attr('id').split(/ticket-/)
      $('#change_table_ticket_id').val(t[1])
      $('#change_table_orig_table_id').val(t[0].match(/\d+/)[0])
      $('#change_table_table_id').val($(this).attr('id').match(/\d+/)[0])
      $.rails.handleRemote($('#change_table'))
    

<% end %>

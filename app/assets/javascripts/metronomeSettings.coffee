$ ->
  manageWidgetry_background()
  manageWidgetry_classic()
  manageWidgetry_log()
  manageWidgetry_entire()

manageWidgetry = (masterElement, slaveElement) ->
  slaveElement.prop('disabled', true) unless masterElement.is(':checked')
  masterElement.click ->
    isMasterChecked = $(@).is(':checked')
    slaveElement.prop('checked', false) unless isMasterChecked
    slaveElement.prop('disabled', not isMasterChecked)

manageWidgetry_background = -> manageWidgetry($('#background'), $('#background_on_all'))
manageWidgetry_classic = -> manageWidgetry($('#classic'), $('#mute_for_classic'))
manageWidgetry_log = -> manageWidgetry($('#log'), $('#log_settings'))

manageWidgetry_entire = ->
  $('.index_field').prop('disabled', true) if $('#use_entire').is(':checked')

  $('#use_entire').click ->
    $('.index_field').prop('disabled', $(@).is(':checked'))










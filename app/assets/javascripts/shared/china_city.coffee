# NOTICE: Don't use the china_city plugin js, it's not work
# NOTICE: If dont't want use turbolinks, then change this to $(document).ready
# $(document).on 'ready page:change', (event) ->

noUnusedCity = (city) ->
  return city[0] != '市辖区' && city[0] != '县'

$ ->
  $('body').delegate '.city-select', 'change', ->
    $group = $('.city-group')
    selects = $group.find('.city-select')

    next_selects = selects.slice(selects.index(@) + 1)
    $("option:gt(0)", next_selects).remove()
    if next_selects.first()[0] and $(this).val() # init next child
      $.get "/china_city/#{$(@).val()}", (data) ->
        # data = data.filter(noUnusedCity)
        # console.log(data)

        next_selects.first()[0].options.add(new Option(option[0], option[1])) for option in data

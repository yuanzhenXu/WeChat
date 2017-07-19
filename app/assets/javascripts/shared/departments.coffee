$ ->
  if $('.department_select').length
    $('.first-level-select').on 'change', ->
      $first_level = $(this)
      $second_level = $('.second-level-select')
      $second_level.html '<option value="-1"></option>'
      # console.log $input.val()
      # console.log typeof($input.val())
      if $first_level.val() != '-1'
        $.get '/departments.json', { first_level_id: $first_level.val() }, (data)-> 
          $.each data, (index, value) ->
            $second_level.append($('<option/>').val(value['id']).text(value['name']))

    $('.second-level-select').on 'change', ->
      $second_level = $(this)
      $third_level = $('.third-level-select')
      $third_level.html '<option value="-1"></option>'
      # console.log $input.val()
      # console.log typeof($input.val())
      if $second_level.val() != '-1'
        $.get '/departments.json', { second_level_id: $second_level.val() }, (data)-> 
          $.each data, (index, value) ->
            $third_level.append($('<option/>').val(value['id']).text(value['name']))

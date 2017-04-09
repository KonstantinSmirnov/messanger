jQuery ($) ->
  $(document).on "turbolinks:load", ->
    $('.textarea-resizable').each( ->
      @.setAttribute 'style', 'height:' + @.scrollHeight + 'px;overflow-y:hidden;'
    ).on 'input', ->
      @.style.height = 'auto'
      @.style.height = @.scrollHeight + 'px'

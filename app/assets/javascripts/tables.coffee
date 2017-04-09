
$ ->
  $(document).on "turbolinks:load", ->
    $(document).on 'click', '.table-clickable tr[data-link]', (evt) ->
      window.location = this.dataset.link
    $('.current.desc').append(" <i class='fa fa-sort-numeric-desc'></i>")
    $('.current.asc').append(" <i class='fa fa-sort-numeric-asc'></i>")

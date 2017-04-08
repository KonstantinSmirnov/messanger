
$ ->
  $(document).on 'click', '.table-clickable tr[data-link]', (evt) -> 
    window.location = this.dataset.link

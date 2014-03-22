jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html("<div>Fetching more products...</div>")
        $.getScript(url)
    $(window).scroll()

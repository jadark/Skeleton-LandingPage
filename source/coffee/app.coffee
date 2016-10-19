class App
  constructor: ->
    @initialize()
    return

  initialize: ->
    self = @
    self.elements = document.getElementsByClassName("block-section")
    self.firstSeccion = self.elements[0]
    self.blockApp = $('.eliot-app')
    self.menuLink = $('.menu-link')
    self.sections = $('.block-section')
    self.nav = $('.header').find('.nav')
    self.header_height = $('.header').outerHeight()
    self.events()
    return

  tabsNew: (ptab, ctab) ->
    $(ptab).on 'click', (e) ->
      e.preventDefault()
      i = $(this).index()
      $(ptab).removeClass 'active'
      $(this).addClass 'active'
      $(ctab).css 'display', 'none'
      $(ctab).eq(i).fadeIn '1000'
      $(this).find('.contTab').fadeIn '1000'
      $(this).find('.contTab').fadeOut '1000'
      return
    $(ptab).eq(0).click()
    return

  checkPos:()->
    self = @
    w = window.innerWidth
    h = window.innerHeight
    for el in self.elements
      hv = false
      vv = false
      pos = el.getBoundingClientRect()
      if pos.left <= w and pos.left >= 0 then hv = true
      if pos.right <= w and pos.right >= 0 then hv = true
      if pos.top <= h and pos.top >= 0 then vv = true
      if pos.bottom <= h and pos.bottom >= 0 then vv = true
      if hv is true and vv is true
        el.classList.add "is-visible"
      else
        el.classList.remove "is-visible"

  events:()->
    self = @
    $(self.firstSeccion).addClass("is-visible")
    $('.type-text').typed
      strings: [
        'Asesoría legal especializada ^1500'
        'Asesoría para obtención de título de abogado ^1500'
        'Supervisión y fiscalización ^1500'
        'Capacitación ^1500'
      ]
      contentType: 'html'
      typeSpeed: 60
      backDelay: 600
      loopCount: false
      loop: true
      callback: ->
        console.log 'Se acaba el listado de frases'
      onStringTyped: ->
        console.log 'Cuando la frase termina'

    swiper = new Swiper('.slider-equipo',
      pagination: '.swiper-pagination'
      paginationClickable: true
      simulateTouch: true)

    swiper = new Swiper('.slider-clientes',
      pagination: '.swiper-pagination'
      paginationClickable: true
      simulateTouch: true
      spaceBetween: 30
      slidesPerView: 'auto'
      grabCursor: true)


    eventType = if document.ontouchstart != null then 'click' else 'touchstart';

    anchorScroll = (event) ->
      id = $(this).attr('href')
      offset = $('.header').height()
      target = $(id).offset().top - offset
      $('html, body').animate { scrollTop: target }, 500
      event.preventDefault()
      return

    self.menuLink.on 'click', ->
      anchorScroll.call(this, event)
      self.menuLink.removeClass('active')
      $(this).addClass('active')
      if $('.hamburger-menu').is(':visible')
        $('.hold-mobile').trigger('click')
      return

    $('.logo').on 'click', ->
      anchorScroll.call(this, event)
      return

    $('.hamburger-menu').on 'click', ->
      $('.bar').toggleClass 'animate'
      if self.blockApp.css('right') is '0px'
        self.blockApp.css 'right', '240px'
        $('.hold-mobile').show()
      else
        self.blockApp.removeAttr 'style'
        $('.hold-mobile').removeAttr 'style'
      return

    $('.hold-mobile').on 'click', ->
      self.blockApp.removeAttr 'style'
      $('.hamburger-menu .bar').removeClass('animate')
      $(this).removeAttr 'style'
      return

    ##Hammver Event SwiperLeft
    # if $('.hamburger-menu').is(':visible')
    #   hammertime = document.querySelector(".eliot-app");
    #   mc = new Hammer(hammertime);
    #   mc.on 'swipeleft', (e) ->
    #     $('.hamburger-menu').trigger("click")
    #     return
    #   mc.on 'swiperight', (e) ->
    #     $('.hold-mobile').trigger("click")
    #     return

    $(window).on 'scroll', ->
      ##self.checkPos()
      if $(this).scrollTop() > 200
        $('.header').addClass('fix-header')
      else if $(this).scrollTop() < 1
        $('.header').removeClass('fix-header')
      cur_pos = $(this).scrollTop()
      console.log cur_pos
      # self.sections.each ->
      #   top = $(this).offset().top - self.header_height
      #   bottom = top + $(this).outerHeight()
      #   if cur_pos >= top and cur_pos <= bottom
      #     self.nav.find('a').removeClass 'active'
      #     self.sections.removeClass 'active'
      #     $(this).addClass 'active'
      #     self.nav.find('a[href="#' + $(this).attr('id') + '"]').addClass 'active'
      return


    ###Formulario ###
    submitForm = ->
      name = $('#name').val()
      email = $('#email').val()
      message = $('#message').val()
      phone = $('#phone').val()
      $.ajax
        type: 'POST'
        url: 'php/form-process.php'
        data: 'name=' + name + '&email=' + email + '&phone=' + phone + '&message=' + message
        success: (text) ->
          if text == 'success'
            formSuccess()
          else
            formError()
            #submitMSG(false,text);
          return
      return

    formSuccess = ->
      $('#contactForm')[0].reset()
      submitMSG true, 'Message Submitted!'
      return

    formError = ->
      $('#contactForm').removeClass().addClass('shake animated').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
        $(this).removeClass()
        return
      return

    submitMSG = (valid, msg) ->
      `var msgClasses`
      if valid
        msgClasses = 'h3 text-center tada animated text-success'
      else
        msgClasses = 'h3 text-center text-danger'
      #$("#msgSubmit").removeClass().addClass(msgClasses).text(msg);
      $('.contentbody').slideUp 350, ->
        $('#msgSubmit').text(msg).fadeIn 200
        return
      return

    ###if $('#contactForm').length > 0
      $('#contactForm').validator().on 'submit', (event) ->
        if event.isDefaultPrevented()
          formError()
        else
          event.preventDefault()
          submitForm()
        return###

    return

do->
  new App()

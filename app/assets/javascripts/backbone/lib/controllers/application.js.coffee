@Artoo.module 'Controllers', (Controllers, App, Backbone, Marionette, $, _) ->
  
  class Controllers.Application extends Marionette.Object
    
    constructor: (options = {}) ->
      @region = options.region or App.request 'default:region'
      super options
      @_instance_id = _.uniqueId('controller')
      App.execute 'register:instance', @, @_instance_id
      
    destroy: ->
      console.log 'destroying', @
      App.execute 'unregister:instance', @, @_instance_id
      super
    
    show: (view, options = {}) ->
      _.defaults options,
        loading: false,
        region:  @region
        
      @setMainView view
      @_manageView view, options
      
    setMainView: (view) ->
      # the first view we show is always going to become the mainView of our
      # controller (whether it's a layout or another view type). So if this
      # *is* a layout, when we show other regions inside of that layout, we
      # check for the existence of a mainView first, so out controller is only
      # closed down when the origin mainView is closed
      
      return if @_mainView
      @_mainView = view
      @listenTo view, 'destroy', @destroy
      
    _manageView: (view, options) ->
      if options.loading
        # show the loading view
        # App.execute 'show:loading', view, options
      else
        options.region.show view
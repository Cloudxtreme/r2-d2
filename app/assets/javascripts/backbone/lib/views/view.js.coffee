@Artoo.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  
  _destroy = Marionette.View::destroy
  
  _.extend Marionette.View::,
  
    addOpacityWrapper: (init = true) ->
      @$el.toggleWrapper
        className: 'opacity'
      , init
      
    setInstancePropertiesFor: (args...) ->
      for key, val of _.pick(@options, args...)
        @[key] = val
  
    destroy: (args...) ->
      if @model?.isDestroyed()
        
        wrapper = @$el.toggleWrapper
          className: 'opacity'
          backgroundColor: 'red'
        
        wrapper.fadeOut 400, ->
          $(@).remove()
          
        @$el.fadeOut 400, =>
          _destroy.apply @, args
          
      else
        _destroy.apply @, args
    
    templateHelpers: ->
      
      currentUser:
        App.request('get:current:user')?.toJSON() ? false
        
      linkTo: (name, url, options = {}, html_options = {}) ->
        
        _.defaults options,
          external: false
        
        unless _.isEmpty html_options
          attributes = _.map html_options, (val, key) ->
            "#{key}='#{val}'"
          .join(' ')
        
        url = '#' + url unless options.external
        
        "<a href='#{url}' #{attributes}>#{@escape(name)}</a>"
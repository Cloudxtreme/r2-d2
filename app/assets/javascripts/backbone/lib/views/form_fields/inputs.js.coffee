@Artoo.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  
  class Views.BaseInput extends App.Views.ItemView
    template: 'form_fields/input'
    
    attributes: ->
      class: 'row'
      id:    @model.get('elementId')
    
    ui: ->
      input: "#{@getTagName()}[name^='#{@getNameAttr()}']"
      
    getTagName: ->
      @model.get 'tagName'
      
    getNameAttr: ->
      @model.get 'name'
    
    events:
      'change @ui.input' : 'updateModelValue'
      
    modelEvents:
      'change:isShown' : 'toggle'
      
    toggle: ->
      @$el.show(200) if @model.get('isShown') is true
      @$el.hide(200) if @model.get('isShown') is false
      
    updateModelValue: ->
      @model.set 'value', @currentValue()
      
    currentValue: ->
      Backbone.Syphon.serialize(@el)[@getNameAttr()]
  
  
  class Views.TextField extends Views.BaseInput
  
  
  class Views.NumberField extends Views.BaseInput
    
  
  class Views.TextArea extends Views.BaseInput
    template: 'form_fields/textarea'
  
        
  class Views.Select extends Views.BaseInput
    template: 'form_fields/select'
  
  
  class Views.CollectionCheckBoxes extends Views.BaseInput
    template: 'form_fields/collection_check_boxes'
    
  
  class Views.RadioButtons extends Views.BaseInput
    template: 'form_fields/radio_buttons'
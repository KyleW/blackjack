class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="res/cards/<%= rankName.toString().toLowerCase() %>-<%= suitName.toLowerCase() %>.png">'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes if @model.get 'revealed'
    @$el.addClass 'covered' unless @model.get 'revealed'

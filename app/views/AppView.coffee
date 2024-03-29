class window.AppView extends Backbone.View

  className: "container"

  template: _.template '
    <button class="playAgain">Play Again</button><br/>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .playAgain": ->
      @model.deal()
      @render()

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    newCard = @deck.pop()
    @add(newCard).last()
    @checkBust() unless @isDealer
    newCard

  stand:-> @trigger "stand"

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  checkBust: ->
    if _.min(@scores()) > 21
      @trigger "youLose"

  playDealer: ->
    if _.max(@scores()) > 16
      @trigger "pickWinner"
    else if _.max(@scores()) < 16
      @hit()
      @playDealer()
    else if @scores().length > 1
      @hit()
      @playDealer()
    else
      @trigger "pickWinner"
class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    newCard = @deck.pop()
    @add(newCard).last()
    @checkBust()
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
      if @isDealer
        @trigger "youWin"
      else
        @trigger "youLose"

  playDealer: ->
    # play as dealer
    # compare scores
    # announce winner
    while @scores[0] < 16 then @hit()

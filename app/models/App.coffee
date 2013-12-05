#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand',=>
      @get('dealerHand').at(0).flip()
      @get('dealerHand').playDealer())
    @get('dealerHand').on('pickWinner',=> @pickWinner())

    @get('playerHand').on('youLose',=> @youLose())
    @get('playerHand').on('youWin',=> @youWin())
    @get('playerHand').on('youTie',=> @youTie())

    @get('dealerHand').on('youLose',=> @youLose())
    @get('dealerHand').on('youWin',=> @youWin())
    @get('dealerHand').on('youTie',=> @youTie())

  youLose: ->
    alert "You lose!"
    $('body').html(new AppView(model: new App()).$el)
  youWin: ->
    alert "You win!"
    $('body').html(new AppView(model: new App()).$el)
  youTie: ->
    alert "It's a tie!"
    $('body').html(new AppView(model: new App()).$el)
  pickWinner: ->
    playerScore = 0
    for i in @get('playerHand').scores()
      if i > playerScore and i < 22 then playerScore = i

    dealerScore = 0
    for i in @get('dealerHand').scores()
      if i > dealerScore and i < 22 then dealerScore = i

    if playerScore > dealerScore
      @youWin()
    else if playerScore < dealerScore
      @youLose()
    else
      @youTie()

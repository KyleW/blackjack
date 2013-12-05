#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @deal()
    @addListeners()

  deal: ->
    # Deal cards
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  addListeners: ->
    # Event Listeners
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

  startGame: ->
    # Check for player blackjack
    if @get('playerHand').checkBlackjack()
      if _.max(@get('dealerHand').scores()) >= 10
        @get('dealerHand').at(0).flip()
        if @get('dealerHand').checkBlackjack()
          return @youTie()
        else
          return @youWin()
      else
        @get('dealerHand').at(0).flip()
        return @youWin()

    # Check for dealer blackjack
    if _.max(@get('dealerHand').scores()) >= 10
      @get('dealerHand').at(0).flip()
      if @get('dealerHand').checkBlackjack()
        return @youLose()
      @get('dealerHand').at(0).flip()

  startOver: ->
    $('body').html(new AppView(model: new App()).$el)

  youLose: ->
    alert "You lose!"
    @startOver()

  youWin: ->
    alert "You win!"
    @startOver()

  youTie: ->
    alert "It's a tie!"
    @startOver()

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

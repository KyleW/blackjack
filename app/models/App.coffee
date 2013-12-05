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

    setTimeout(=>
      @startGame()
    ,1500)


  addListeners: ->
    # Event Listeners
    @get('playerHand').on('stand',=>
      @get('dealerHand').at(0).flip()
      @get('dealerHand').playDealer())
    @get('dealerHand').on('pickWinner',=> @pickWinner())

    @get('playerHand').on('youLose',=> @endGame("lose"))
    @get('playerHand').on('youWin',=> @endGame("win"))
    @get('playerHand').on('youTie',=> @endGame("tie"))

    @get('dealerHand').on('youLose',=> @endGame("lose"))
    @get('dealerHand').on('youWin',=> @endGame("win"))
    @get('dealerHand').on('youTie',=> @endGame("tie"))

  startGame: ->
    # Check for player blackjack
    if @get('playerHand').checkBlackjack()
      if _.max(@get('dealerHand').scores()) >= 10
        @get('dealerHand').at(0).flip()
        if @get('dealerHand').checkBlackjack()
          return @endGame("tie")
        else
          return @endGame("win")
      else
        @get('dealerHand').at(0).flip()
        return @endGame("win")

    # Check for dealer blackjack
    if _.max(@get('dealerHand').scores()) >= 10
      @get('dealerHand').at(0).flip()
      if @get('dealerHand').checkBlackjack()
        return @endGame("lose")
      @get('dealerHand').at(0).flip()

  # playAgain: ->
  #   @deal()
    # $('body').html(new AppView(model: new App()).$el)

  endGame:(result)->
    alert "You #{result}!"
    $('.playAgain').show()
    # show play again button?

  pickWinner: ->
    playerScore = 0
    for i in @get('playerHand').scores()
      if i > playerScore and i < 22 then playerScore = i

    dealerScore = 0
    for i in @get('dealerHand').scores()
      if i > dealerScore and i < 22 then dealerScore = i

    if playerScore > dealerScore
      @endGame("win")
    else if playerScore < dealerScore
      @endGame("lose")
    else
      @endGame("tie")

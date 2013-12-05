#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand',=> @get('dealerHand').playDealer())
    @get('dealerHand').on('pickWinner',=> @pickWinner())

    @get('playerHand').on('youLose',=> @youLose())
    @get('playerHand').on('youWin',=> @youWin())
    @get('playerHand').on('youTie',=> @youTie())

    @get('dealerHand').on('youLose',=> @youLose())
    @get('dealerHand').on('youWin',=> @youWin())
    @get('dealerHand').on('youTie',=> @youTie())

  youLose: -> alert "You lose!"
  youWin: -> alert "You win!"
  youTie: -> alert "It's a tie!"
  # pickWinner: ->
  #   playerScore = if _.max()
  #   dealerScore = if
  #   if @get('playerHand').scores() > @get('dealerHand').scores

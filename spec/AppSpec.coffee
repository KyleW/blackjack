describe "Check for busts after hit", ->
  app = undefined
  hand = undefined

  beforeEach ->
    app = new App()
    hand = app.get('playerHand')

  it "If a player hits, checkBust should run", ->
    spyOn(hand, 'checkBust')
    hand.hit()
    expect(hand.checkBust).toHaveBeenCalled()

  it "If you hit, and have less than 22 you lose should not fire", ->
    spyOn(hand, 'scores').andReturn([20])
    spyOn(app, 'youLose')
    hand.hit()
    expect(app.youLose).not.toHaveBeenCalled()

describe "The game correctly determins the winner if ", ->
  app = undefined
  hand = undefined
  dealer = undefined

  beforeEach ->
    app = new App()
    hand = app.get('playerHand')
    dealer = app.get('dealerHand')

  it "the player busts.", ->
    spyOn(hand, 'scores').andReturn([30])
    spyOn(app, 'youLose')
    hand.hit()
    expect(app.youLose).toHaveBeenCalled()

  it "the dealer busts", ->
    spyOn(dealer, 'scores').andReturn([30])
    spyOn(app, 'youWin')
    dealer.playDealer()
    expect(app.youWin).toHaveBeenCalled()

  it "no one busts and the dealer has a higher score.", ->
    spyOn(hand, 'scores').andReturn([12])
    spyOn(dealer, 'scores').andReturn([20])
    spyOn(app, "youLose")
    hand.stand()
    expect(app.youLose).toHaveBeenCalled()

  it "no one busts and the player has a higher score.", ->
    spyOn(hand, 'scores').andReturn([21])
    spyOn(dealer, 'scores').andReturn([18])
    spyOn(app, "youWin")
    hand.stand()
    expect(app.youWin).toHaveBeenCalled()

  it "no one busts and the player and the dealer have the same score.", ->
    spyOn(hand, 'scores').andReturn([18])
    spyOn(dealer, 'scores').andReturn([18])
    spyOn(app, "youTie")
    hand.stand()
    expect(app.youTie).toHaveBeenCalled()

  it "the dealer gets blackjack.", ->
    spyOn(hand, 'scores').andReturn([18])
    spyOn(dealer, 'scores').andReturn([21])
    spyOn(app, "youTie")
    hand.stand()
    expect(app.youTie).toHaveBeenCalled()

  # it "the player gets blackjack.", ->

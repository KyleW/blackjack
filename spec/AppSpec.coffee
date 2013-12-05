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

  it "If you hit, and have more than 21 you lose should fire", ->
    spyOn(hand, 'scores').andReturn([30])
    spyOn(app, 'youLose')
    hand.hit()
    expect(app.youLose).toHaveBeenCalled()

  it "If you hit, and have less than 22 you lose should not fire", ->
    spyOn(hand, 'scores').andReturn([20])
    spyOn(app, 'youLose')
    hand.hit()
    expect(app.youLose).not.toHaveBeenCalled()

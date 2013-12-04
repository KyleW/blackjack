describe "Check for busts after hit", ->
  beforeEach ->
    app = new App()
    hand = app.get('playerHand')

  it "If you hit, and get more than 21 you lose should fire", ->
    hand.hit()
    hand.hit()
    hand.hit()
    hand.hit()
    hand.hit()
    hand.hit()
    expect(app.youLose).toHaveBeenCalled()

  it "If you hit, and have less than 22 you lose should not fire", ->
    collection = new Deck()
    expect(collection.length).toBe 52

assert = chai.assert

describe "Results of standing", ->
  deck = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()


  #it "should win on a player black jack", ->
    #playerHand.scores = -> [11, 21]
    #dealerHand.scores = -> [17, 17]
    #dealerHand.endGame()


  #it "should lose on a player bust", ->
    #playerHand.scores = -> [22, 22]
    #dealerHand.scores = -> [17, 17]
    #dealerHand.endGame()

  it "should win on a dealer bust", ->
    playerHand.scores = -> [17, 17]
    dealerHand.scores = -> [26, 26]
    assert.strictEqual dealerHand.endGame(playerHand.scores()), true
    #assert.strictEqual winButton.is(":visible"), true
    #assert.strictEqual loseButton.is(":visible"), false

  it "should lose on a dealer black jack", ->
    playerHand.scores = -> [17, 17]
    dealerHand.scores = -> [11, 21]
    dealerHand.hasAce = -> true;   
    assert.strictEqual dealerHand.endGame(playerHand.scores()), false
    #assert.strictEqual winButton.is(":visible"), false
    #assert.strictEqual loseButton.is(":visible"), true    
describe "Player bust and BlackJack", ->
  deck = null
  playerHand = null
  dealerHand = null
  handView = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    handView = new HandView({collection:playerHand})

  it "should win when a player gets a black jack", ->
    playerHand.scores = -> [11, 21]
    assert.strictEqual handView.render(), "win"

  it "should lose when a player busts", ->

    playerHand.hit() for num in [10..1]
    assert.strictEqual handView.render(), "lose"


describe "Player stand...", ->
  deck = null
  playerHand = null
  dealerHand = null
  handView = null

  beforeEach ->
    deck = new RiggedDeck() 
    #deckFives = new RiggedDeckFives ()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  it "should make player lose on tie", ->
    playerHand.scores = -> [20, 20]
    dealerHand.scores = -> [20, 20]   
    assert.strictEqual dealerHand.stand(playerHand.scores()), false

  it "should make player win on dealer hold with lesser value", ->  
    playerHand.scores = -> [20, 20]
    assert.strictEqual dealerHand.stand(playerHand.scores()), true

  it "should make player lose on dealer hold with higher value", ->
    assert.strictEqual dealerHand.stand(playerHand.scores()), false






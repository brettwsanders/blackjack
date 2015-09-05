class window.Hand extends Backbone.Collection
  model: Card


  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()

  stand: (playerScores) -> 
    @at(0).flip()
    @endGame(playerScores)
    


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  endGame: (playerScores) ->
    while @scores()[0] <= 16 then @hit()
    playerScoreMin = playerScores[0]
    dealerScoreMin = @scores()[0]
    playerScoreMax = playerScores[1]
    dealerScoreMax = @scores()[1]
    debugger

    #check for player busted
    if playerScoreMin > 21 then playerScoreMin = 0

    #if max scores over 21 then set to min scores and then compare to find winner
    if dealerScoreMin > 21 then dealerScoreMin = 0
    if playerScoreMax > 21 then playerScore = playerScoreMin else playerScore = playerScoreMax
    if dealerScoreMax > 21 then dealerScore = dealerScoreMin else dealerScore = dealerScoreMax

    @trigger("gameOver", playerScore > dealerScore)
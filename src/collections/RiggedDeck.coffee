class window.RiggedDeck extends Backbone.Collection
  #model: Card
  card: 6
  initialize: ->
    @add _([0...52]).shuffle().map (card) =>
      context = @
      new Card
        rank: context.card
        suit: 0

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @ 

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
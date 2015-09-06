class window.RiggedDeck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).map (card) ->
      new Card
        rank: @card
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@pop(), @pop()], @ 

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
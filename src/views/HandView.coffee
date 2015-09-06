class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    context = @
    @collection.on "gameOver", (result) ->
      if !!result
        $(".win-result").show()
        
        context.updateButtons()
      else
        $(".lose-result").show()
        
        context.updateButtons()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[1]
    if @collection.scores()[1] > 21 then @$('.score').text @collection.scores()[0]
    if @collection.scores()[0] > 21 then return @busted()
    if @collection.scores()[0] == 21 or @collection.scores()[1] == 21 then @blackJack()

  busted: ->
    @$('.score').append("<span> Busted!</span>")
    @endGame('lose')

  blackJack: ->
    @$('.score').append("<span> Blackjack!</span>")
    @endGame('win')

  endGame: (result) ->
    console.log(@collection)
    if result == 'lose' and !@collection.isDealer then $(".lose-result").show()
    else if result == 'win' and !@collection.isDealer then $(".win-result").show()
    else if result == 'lose' and @collection.isDealer then $(".win-result").show()
    else if result == 'win' and @collection.isDealer then $(".lose-result").show()
    @updateButtons()
    result

  updateButtons: ->
    $(".hit-button").hide()
    $(".stand-button").hide()
    $(".new-deal-button").show()

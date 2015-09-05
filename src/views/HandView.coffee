class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on "gameOver",(result) -> if !!result then $(".win-result").show() else $(".lose-result").show()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    if @collection.scores()[1] == 21 then @$('.score').text('21')
    if @collection.scores()[0] > 21 then @busted()
    if @collection.scores()[0] == 21 or @collection.scores()[1] == 21 then @blackJack()

  busted: ->
    @$('.score').append("<span> Busted!</span>")
    @endGame('lose')

  blackJack: ->
    @$('.score').append("<span> Blackjack!</span>")
    @endGame('win')

  endGame: (result) ->
    if result == 'lose' and !@isDealer then $(".lose-result").show()
    else if result == 'win' and !@isDealer then $(".win-result").show()
    else if result == 'lose' and @isDealer then $(".win-result").show()
    else if result == 'win' and @isDealer then $(".lose-result").show()
    $(".hit-button").hide()
    $(".stand-button").hide()
    $(".new-deal-button").show()


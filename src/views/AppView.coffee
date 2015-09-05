class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-deal-button" hidden>Next Round</button>
    <div class="lose-result" hidden>You lose!</div>
    <div class="win-result" hidden>You win!</div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand(@model.get('playerHand').scores()) and @endGame()
    'click .new-deal-button': -> @model.newDeal() and @render()

  initialize: ->
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  endGame: ->
    $(".hit-button").hide()
    $(".stand-button").hide()
    $(".new-deal-button").show()

class window.AppView extends Backbone.View

  className: 'container'

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <div class="judge-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @model.get('playerHand').on('bust',
      ()=>
        @model.get('dealerHand').reveal()
        console.log('busted') )
    @model.get('playerHand').on('stand',
      ()=> 
        @model.get('dealerHand').reveal()
        @model.get('dealerHand').play() )
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.judge-container').html new JudgeView(model: @model.get 'judge').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

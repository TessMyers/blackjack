#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'newRound', =>
      console.log 'newRound heard'
      @set 'playerHand', deck.dealPlayer()

      console.log(@get('playerHand'), "second playerHand")
      @set 'dealerHand', deck.dealDealer()
      # console.log @get 'playerHand',

    console.log(@get('playerHand'), "first playerHand")

class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    # todo also

  hit: ->
    #if statement to see if @isDealer
    #automate hitting
    #
    @add(@deck.pop()).last()
    @check();

  check: ->
    if @isDealer then @checkDealer() else @checkPlayer()

  checkDealer: ->
    pScore = $('.player-hand-container').find('.score').text()

    if @scores()[0] is 21 or @scores()[1] is 21
      alert 'Dealer wins'
      @trigger 'roundEnded'
    else if @scores()[0] > 21 or !@scores()[1]? and @scores()[1] > 21
      alert 'Dealer busts! You win :)'
      @trigger 'roundEnded'


    # CLEAN THIS UP YO

    if @scores()[0] > 17 or !@scores()[1]? and @scores()[1] > 17
      #then dealer ends game
    else if (@scores()[0] == 17 or !@scores()[1]? and @scores()[1] == 17) and (playerScore == 17)
      alert 'Game is a tie!'
      @trigger 'roundEnded'
    else @hit()

  checkPlayer: ->
    if @scores()[0] > 21 or !@scores()[1]? and @scores()[1] > 21
      alert 'Bust! You lose :('
      @trigger('roundEnded')
    else if @scores()[0] is 21 or @scores()[1] is 21
      alert 'Blackjack! You win everything!'
      @trigger('roundEnded')


  newRound: ->
    @remove(@models)
    if @isDealer
      @add(@deck.pop().flip())
      @hit()
    else
      @hit()
      @hit()

  stand: ->
    console.log('Standing!');


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

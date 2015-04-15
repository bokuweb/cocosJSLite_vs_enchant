class window.Game
  require './enchant'
  $ = require 'jquery'
  constructor : (w, h)->
    enchant()
    @_game = new Core w, h
    @_game.fps = 60

  start : (@_num)=>
    @_game.preload ["res/test1.png"]
    @_load().then @_play

  _load : ->
    d = new $.Deferred
    @_game.start()
    @_game.onload = -> d.resolve()
    d.promise()

  _play : =>
    for i in [0...@_num]
      sprite = new Sprite 16, 16
      sprite.image = @_game.assets["res/test1.png"]
      sprite.x = 400
      sprite.y = 320
      sprite.dir =
        x : Math.random() * 20 - 10
        y : Math.random() * 20 - 10
      sprite.addEventListener "enterframe", ->
        @x +=  @dir.x
        @y +=  @dir.y
        @dir.x *= -1 if @x >= 800 or @x <= 0
        @dir.y *= -1 if @y >= 640 or @y <= 0
      @_game.currentScene.addChild sprite

    fps = new Label()
    fps.color = '#fff'
    @_game.currentScene.addChild fps
    fps.addEventListener 'enterframe', ->
      currentTime = new Date()
      fps = 1000 / (currentTime - @_oldTime)
      @_oldTime = currentTime
      @text = fps.toFixed(2) + " FPS"






PlayerManager = require "./PlayerManager"
EventHandler = require "./EventHandler"
MonsterManager = require "./MonsterManager"
MessageCreator = require "./MessageCreator"
ComponentDatabase = require "./ComponentDatabase"
EquipmentGenerator = require "./EquipmentGenerator"
Constants = require "./Constants"
GMCommands = require "./GMCommands"
Party = require "../event/Party"
Battle = require "../event/Battle"
World = require "../map/World"

_ = require "underscore"
chance = (new require "Chance")()

console.log "Rebooted IdleLands."

class Game

  #Constants either go here, or in a Constants class

  constructor: () ->
    @parties = []
    @playerManager = new PlayerManager @
    @monsterManager = new MonsterManager()
    @eventHandler = new EventHandler @
    @equipmentGenerator = new EquipmentGenerator @
    @componentDatabase = new ComponentDatabase @
    @gmCommands = new GMCommands @
    @world = new World()

  registerBroadcastHandler: (@broadcastHandler, @broadcastContext) ->
    console.info "Registered broadcast handler."
    @broadcast MessageCreator.generateMessage "Initializing the Lands that Idle (#{Constants.gameName})."

  broadcast: (message) ->
    return if not message
    if @broadcastHandler
      (@broadcastHandler.bind @broadcastContext, message)()
    else
      console.error "No broadcast handler registered. Cannot send: #{message}"

  createParty: (player) ->
    players = _.without @playerManager.players, player

    partyAdditionSize = Math.min (players.length / 2), chance.integer {min: 1, max: Constants.defaults.maxPartySize}
    newPartyPlayers = _.sample (_.reject players, (player) -> player.party), partyAdditionSize

    return if newPartyPlayers.length is 0

    partyPlayers = [player].concat newPartyPlayers

    new Party @, partyPlayers

  startBattle: (parties = []) ->
    return if @inBattle
    return if parties.length < 2 and @parties.length < 2 and @playerManager.players.length < 2

    if parties.length is 0 and @parties.length < 2 and chance.bool {likelihood: 50}
      potentialPlayers = _.sample (_.reject @playerManager.players, (player) -> player.party), 2
      return if potentialPlayers.length < 2
      parties = [ (new Party @, potentialPlayers[0]), (new Party @, potentialPlayers[1])]

    else
      potentialParties = _.sample @parties, 2
      return if potentialParties.length < 2
      parties = potentialParties

    @inBattle = true
    new Battle @,parties

  teleport: (player, map, x, y, text) ->
    player.map = map
    player.x = x
    player.y = y
    @broadcast MessageCreator.genericMessage text

  nextAction: (identifier) ->
    @playerManager.playerTakeTurn identifier

module.exports = exports = Game
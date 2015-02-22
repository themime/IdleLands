
TimedEffect = require "../base/TimedEffect"

class DazeEffect extends TimedEffect
  @name = DazeEffect::name = "DazeEffect"

  `/**
    * Reduces intelligence and wisdom.
    *
    * @name Daze
    * @effect -20% INT
    * @effect -20% WIS
    * @package TimedEffects
  */`

  intPercent: -> -20
  wisPercent: -> -20

  constructor: ->
    super

module.exports = exports = DazeEffect


Achievement = require "../base/Achievement"
{toRoman} = require "roman-numerals"
_ = require "lodash"

`/**
  * This achievement is earned by killing a unique number of bosses.
  *
  * @name Bossy
  * @prerequisite Kill 3*[5*[n-1]+1] unique bosses.
  * @reward +2% AGI
  * @reward +2% DEX
  * @category Achievements
  * @package Player
*/`
class Bossy extends Achievement

  getAllAchievedFor: (player) ->
    baseStat = (_.keys player.statistics['calculated boss kills']).length

    currentCheckValue = 3
    killInterval = 5
    achieved = []
    level = 1

    while baseStat >= currentCheckValue
      item =
        name: "Bossy #{toRoman level}"
        desc: "Kill #{currentCheckValue} unique bosses"
        reward: "+2% AGI, +2% DEX"
        agiPercent: -> 2
        dexPercent: -> 2
        type: "combat"

      item.title = "Boss" if level is 5

      achieved.push item

      currentCheckValue *= killInterval
      level++

    achieved


module.exports = exports = Bossy
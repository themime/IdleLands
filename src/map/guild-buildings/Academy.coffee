
GuildBuilding = require "../GuildBuilding"

`/**
 * The Academy affects the capability of your minor permanent buffs as well as the major buffs you can purchase for a limited time.
 *
 * @name Academy
 * @category Buildings
 * @package Guild Bases
 * @cost {level-up} 15000 (if level <= 100)
 * @property AutoRenew (Yes/No; whether or not to auto renew buffs upon expiration)
 * @size {md}
 */`
class Academy extends GuildBuilding

  @size = Academy::size = "md"
  @desc = Academy::desc = "Upgrade this building to make your buffs better and get some permanent ones!"
  @levelupCost = Academy::levelupCost = (level) -> if level > 100 then level * (50000 + (25000*Math.floor level/100)) else 15000

  f =
    name: "Instructor"
    gid: 12
    type: "Guild NPC"
    properties: {}

  tiles: [
    0,  0,  0,  0,  0,
    0,  f,  0, 44,  0,
    0,  0,  0,  0,  0,
    0,  44, 0, 44,  0,
    0,  0,  0,  0,  0
  ]

module.exports = exports = Academy
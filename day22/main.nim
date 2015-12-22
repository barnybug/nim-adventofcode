import queues
import sets

const bossDamage = 9

type State = object
  mana: int
  manaSpent: int
  hit: int
  bossHit: int
  shieldLeft: int
  poisonLeft: int
  rechargeLeft: int

proc applyEffects(state: var State) =
  if state.poisonLeft > 0:
    state.bossHit -= 3
    dec state.poisonLeft

  if state.rechargeLeft > 0:
    state.mana += 101
    dec state.rechargeLeft

type Spell = object
  cost: int
  modifier: proc(s: var State)
  condition: proc(s: State): bool

var spells = [
  # Magic Missile costs 53 mana. It instantly does 4 damage.
  Spell(cost: 53, modifier: proc(s: var State) = s.bossHit -= 4, condition: proc(s: State): bool = true),
  # Drain costs 73 mana. It instantly does 2 damage and heals you for 2 hit
  # points.
  Spell(cost: 73, modifier: proc(s: var State) = s.bossHit -= 2; s.hit += 2, condition: proc(s: State): bool = true),
  # Shield costs 113 mana. It starts an effect that lasts for 6 turns. While
  # it is active, your armor is increased by 7.
  Spell(cost: 113, modifier: proc(s: var State) = s.shieldLeft = 6, condition: proc(s: State): bool = s.shieldLeft == 0),
  # Poison costs 173 mana. It starts an effect that lasts for 6 turns. At the
  # start of each turn while it is active, it deals the boss 3 damage.
  Spell(cost: 173, modifier: proc(s: var State) = s.poisonLeft = 6, condition: proc(s: State): bool = s.poisonLeft == 0),
  # Recharge costs 229 mana. It starts an effect that lasts for 5 turns. At
  # the start of each turn while it is active, it gives you 101 new mana.
  Spell(cost: 229, modifier: proc(s: var State) = s.rechargeLeft = 5, condition: proc(s: State): bool = s.rechargeLeft == 0),
]

proc play(initialState: State, hard: bool): int =
  var states = initQueue[State]()
  states.enqueue(initialState)
  result = int.high

  while len(states) > 0:
    var state = states.dequeue
    if hard:
      dec state.hit
      if state.hit <= 0:
        continue
    applyEffects(state)
    if state.shieldLeft > 0:
      dec state.shieldLeft

    if state.bossHit <= 0:
      result = min(result, state.manaSpent)
      continue

    for spell in spells:
      if state.mana >= spell.cost and state.manaSpent + spell.cost < result and spell.condition(state):
        var nextState = state
        nextState.mana -= spell.cost
        nextState.manaSpent += spell.cost
        spell.modifier(nextState)
        if nextState.bossHit <= 0: # boss dead
          result = min(result, nextState.manaSpent)
        else: # boss turn
          applyEffects(nextState)
          if nextState.bossHit <= 0: # boss dead on their turn
            result = min(result, nextState.manaSpent)
            continue

          if nextState.shieldLeft > 0:
            nextState.hit -= max(bossDamage-7, 1)
            dec nextState.shieldLeft
          else:
            nextState.hit -= bossDamage

          if nextState.hit > 0:
            states.enqueue(nextState)
  
var initialState = State(mana: 500, hit: 50, bossHit: 51)
echo "Answer #1: ", play(initialState, false)
echo "Answer #2: ", play(initialState, true)

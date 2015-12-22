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

proc bossPlay(state: var State): bool =
  # returns true if the game can continue (player is not dead)
  var armour = 0
  applyEffects(state)
  if state.bossHit <= 0:
    return true

  if state.shieldLeft > 0:
    state.hit -= max(bossDamage-7, 1)
    dec state.shieldLeft
  else:
    state.hit -= bossDamage

  return state.hit > 0

proc play(initialState: State, hard: bool): int =
  var states = initQueue[State]()
  states.enqueue(initialState)

  var bestManaSpent = int.high
  var lastBestManaSpent = int.high

  while len(states) > 0:
    var state = states.dequeue
    if hard:
      state.hit -= 1
      if state.hit <= 0:
        continue
    applyEffects(state)
    if state.shieldLeft > 0:
      dec state.shieldLeft

    if state.bossHit <= 0:
      bestManaSpent = min(bestManaSpent, state.manaSpent)
      continue

    if bestManaSpent < state.manaSpent + 53:
      continue

    # Possible moves:

    # Magic Missile costs 53 mana. It instantly does 4 damage.
    if state.mana >= 53 and state.manaSpent + 53 < bestManaSpent:
      var nextState = state
      nextState.mana -= 53
      nextState.manaSpent += 53
      nextState.bossHit -= 4
      if nextState.bossHit <= 0:
        bestManaSpent = min(bestManaSpent, nextState.manaSpent)
      else:
        if bossPlay(nextState):
          states.enqueue(nextState)

    # Drain costs 73 mana. It instantly does 2 damage and heals you for 2 hit
    # points.
    if state.mana >= 73 and state.manaSpent + 73 < bestManaSpent:
      var nextState = state
      nextState.mana -= 73
      nextState.manaSpent += 73
      nextState.bossHit -= 2
      nextState.hit += 2
      if nextState.bossHit <= 0:
        bestManaSpent = min(bestManaSpent, nextState.manaSpent)
      else:
        if bossPlay(nextState):
          states.enqueue(nextState)

    # Shield costs 113 mana. It starts an effect that lasts for 6 turns. While
    # it is active, your armor is increased by 7.
    if state.mana >= 113 and state.shieldLeft == 0 and state.manaSpent + 113 < bestManaSpent:
      var nextState = state
      nextState.mana -= 113
      nextState.manaSpent += 113
      nextState.shieldLeft = 6
      if bossPlay(nextState):
        states.enqueue(nextState)

    # Poison costs 173 mana. It starts an effect that lasts for 6 turns. At the
    # start of each turn while it is active, it deals the boss 3 damage.
    if state.mana >= 173 and state.poisonLeft == 0 and state.manaSpent + 173 < bestManaSpent:
      var nextState = state
      nextState.mana -= 173
      nextState.manaSpent += 173
      nextState.poisonLeft = 6
      if bossPlay(nextState):
        states.enqueue(nextState)

    # Recharge costs 229 mana. It starts an effect that lasts for 5 turns. At
    # the start of each turn while it is active, it gives you 101 new mana.
    if state.mana >= 229 and state.rechargeLeft == 0 and state.manaSpent + 229 < bestManaSpent:
      var nextState = state
      nextState.mana -= 229
      nextState.manaSpent += 229
      nextState.rechargeLeft = 5
      if bossPlay(nextState):
        states.enqueue(nextState)

  return bestManaSpent
  
var initialState = State(mana: 500, hit: 50, bossHit: 51)
echo "Answer #1: ", play(initialState, false)
echo "Answer #2: ", play(initialState, true)
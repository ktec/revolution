import { createSyncLabel } from "../common/sync_labels"

// createCard :: State -> Channel -> String ->  String -> Eff Sprite
export const createCard = state => channel => (id, text, x, y) => {
  const label = createSyncLabel(state, text, channel, id)
  label.x = x
  label.y = y
  label.fontSize = 18
  return label
}

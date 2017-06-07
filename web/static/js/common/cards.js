import { createLabel } from "./labels"
import { syncPosition } from "./sync"

// createCard :: State -> Channel -> String ->  String -> Eff Sprite
export const createCard = state => channel => (id, message, x, y) => {

  const style = {
    font: "65px Arial",
    fill: "#ffffff",
    align: "center",
    backgroundColor: "#000000"
  }

  const label = createLabel(state, message, style)
  label.anchor.setTo(0.5)
  label.inputEnabled = true
  label.input.enableDrag()

  label.id = id

  // send message on drag stop [sprite, channel, event]
  syncPosition(label, channel, label.events.onDragUpdate)

  label.x = x
  label.y = y
  label.fontSize = 18
  return label
}

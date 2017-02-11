import { createLabel } from "../common/labels"
import { createCard } from "../common/cards"
import { leaveChannel } from "../common/channels"

export class Play extends Phaser.State {
  create(game) {
    game.stage.backgroundColor = 0x86836d

    const label2 = createLabel(this, "Click to return to Lobby")
    label2.anchor.setTo(0.5)
    label2.inputEnabled = true
    label2.y += 200
    label2.fontSize = 12
    label2.events.onInputDown.add(() =>
      leaveChannel(this.channel, game.gotoLobby)
    )
    const cardFactory = createCard(this)(this.channel)

    this.cards = {}
    this.channel.on("get_cards", ({cards}) => {
      Object.entries(cards).map((card) => {
        const [id, [name, x, y]] = card
        const sprite = cardFactory(id, name, x, y)
        sprite.events.onDragStop.add(this.stopDrag.bind(this))
        this.cards[id] = sprite
      })
    })
    this.channel.push("get_cards")

    this.channel.on("match_found", ({right, left}) => {
      console.log(right, left)
      this.cards[right].kill()
      this.cards[left].kill()
      this.cards[left] = null
      this.cards[right] = null
    })

    this.channel.on("no_match", ({msg}) => {
      console.log(msg)
      // may the card should jump back to its origin?
    })

  }

  stopDrag(currentSprite) {
    Object.entries(this.cards).map(([id, sprite]) => {
      if (currentSprite != sprite) {
        const isOverlap = this.checkOverlap(currentSprite, sprite)
        if (isOverlap) {
          this.channel.push("submit_match", {left: currentSprite.id, right: sprite.id})
        }
      }
    })
  }

  checkOverlap(spriteA, spriteB) {
    if (spriteA && spriteB) {
      const boundsA = spriteA.getBounds()
      const boundsB = spriteB.getBounds()
      return Phaser.Rectangle.intersects(boundsA, boundsB)
    } else {
      return false
    }
  }

  init(...options) {
    console.log("starting Play state")
    const [channel] = options
    this.channel = channel
  }
}

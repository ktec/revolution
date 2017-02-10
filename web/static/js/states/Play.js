import { createLabel } from "../common/labels"
import { createSyncLabel } from "../common/sync_labels"
import { leaveChannel } from "../common/channels"

export class Play extends Phaser.State {
  create(game) {
    game.stage.backgroundColor = 0x551A8B


    const label2 = createLabel(this, "Click to return to Lobby")
    label2.anchor.setTo(0.5)
    label2.inputEnabled = true
    label2.y += 100
    label2.events.onInputDown.add(() =>
      leaveChannel(this.channel, game.gotoLobby)
    )

    this.channel.on("get_cards", ({cards}) => {
      Object.entries(cards).map((card) => {
        this.createCard(...card)
      })
    })
    this.channel.push("get_cards")
    this.cards = {}
  }

  createCard(id, value) {
    const label = createSyncLabel(this, value, this.channel, id)
    // const {x, y} = this.randomPosition(label)
    // this.label.x = x
    // this.label.y = y
    this.cards[id] = label
  }

  // randomPosition({width, height}) {
  //   const mx = this.game.width - width
  //   const my = this.game.height - height
  //   const randomX = this.game.rnd.integerInRange(0, mx)
  //   const randomY = this.game.rnd.integerInRange(0, my)
  //   return {x: randomX, y: randomY}
  // }

  init(...options) {
    console.log("starting Play state")
    const [channel] = options
    this.channel = channel
  }
}

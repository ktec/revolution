import { createLabel } from "../common/labels"
import { createSyncLabel } from "../common/sync_labels"
import { syncPosition } from "../common/sync"
import { leaveChannel } from "../common/channels"

export class Lobby extends Phaser.State {
  init(...args) {
    console.log("starting Lobby state")
    const [channel] = args
    this.channel = channel
   }

  create(game) {
    game.stage.backgroundColor = 0x000000

    const label = createSyncLabel(this, "Move me!", this.channel, "1")

    const label2 = createLabel(this, "Click to Play")
    label2.anchor.setTo(0.5)
    label2.inputEnabled = true
    label2.y += 100
    label2.events.onInputDown.add(() =>
      leaveChannel(this.channel, game.gotoPlay)
    )
  }
}

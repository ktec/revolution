import { createLabel } from "../common/labels"
import { syncPosition } from "../common/sync"
import { leaveChannel } from "../common/channels"

import { startButtonURI } from "../common/buttons"

export class Lobby extends Phaser.State {
  init(...args) {
    console.log("starting Lobby state")
    const [channel] = args
    this.channel = channel
   }

   preload() {
    //  this.game.load.image('startButton', startButtonURI)
   }

  create(game) {
    game.stage.backgroundColor = 0x626267

    // Load a graphic start button:
    // this.startButton = this.game.add.sprite(this.game.world.centerX, this.game.world.height, 'startButton')
    // this.startButton.anchor.setTo(0.5, 0.5)
    // this.game.physics.arcade.enable(this.startButton)
    // this.startButton.tint= 0xff00ff

    const label2 = createLabel(this, "Start Game")
    label2.anchor.setTo(0.5)
    label2.inputEnabled = true
    label2.events.onInputDown.add(() =>
      leaveChannel(this.channel, game.gotoPlay)
    )
  }
}

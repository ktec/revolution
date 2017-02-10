// Import dependencies
import {Game} from "./Game"
import {Socket} from "phoenix"

const token = document.head.querySelector("[name=token]").content
const socket = new Socket("/socket", {
  params: {token: token},
  // logger: (kind, msg, data) => { console.log(`: `, data) }
})
const game = new Game(700, 450, "phaser")

// Lets go!
game.start(socket)

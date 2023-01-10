import { Camera } from './camera'
import { Library } from './library'
import * as push from './libs/push'

export const camera = new Camera()
const lib = new Library()

love.load = () => {
  const seed = os.time()
  math.randomseed(seed)
}

love.update = (dt) => {}

love.draw = () => {
  push.start()
  camera.start()

  lib.draw()

  camera.finish()
  push.finish()
}

love.resize = (w, h) => {
  push.resize(w, h)
}

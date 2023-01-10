import { Transform } from 'love.math'
import * as push from './libs/push'

export class Camera {
  x: number = 0
  y: number = 0
  width: number = 0
  height: number = 0
  transform: Transform = love.math.newTransform()

  constructor() {
    this.width = push.getWidth()
    this.height = push.getHeight()
  }

  start() {
    love.graphics.push()
    this.transform.reset()
    this.transform.translate(this.width / 2, this.height / 2)
    this.transform.translate(-this.x, -this.y)
    love.graphics.applyTransform(this.transform)
  }

  finish() {
    love.graphics.pop()
  }

  toWorld(x: number, y: number) {
    return this.transform.inverseTransformPoint(x, y)
  }
}

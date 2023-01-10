import { Shader } from 'love.graphics'

export type PushSettings = {
  fullscreen?: boolean
  resizable?: boolean
  canvas?: boolean
  pixelperfect?: boolean
  highdpi?: boolean
  stretched?: boolean
}

export type CanvasSettings = {
  name: string
  shader: Shader[]
}

export const setupScreen: (
  gameWidth: number,
  gameHeight: number,
  windowWidth: number,
  windowHeight: number,
  settings: PushSettings
) => void
export const start: () => void
export const finish: () => void
export const apply: (operation: 'start' | 'end') => void
export const resize: (width: number, height: number) => void
export const setShader: (shaders: Shader[]) => void
export const setupCanvas: (canvases: CanvasSettings[]) => void
export const switchFullscreen: (width: number, height: number) => void
export const toGame: (x: number, y: number) => LuaMultiReturn<[number, number]>
export const toReal: (x: number, y: number) => LuaMultiReturn<[number, number]>
export const getDimensions: () => LuaMultiReturn<[number, number]>
export const getWidth: () => number
export const getHeight: () => number

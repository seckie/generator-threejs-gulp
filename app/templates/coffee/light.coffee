'use strict'

init = (scene) ->
  light = new THREE.DirectionalLight(0xFFFFFF, 1.0, 0)
  light.position.set(20, 180, 1000)
  scene.add(light)

  light2 = new THREE.AmbientLight(0x333333)
  scene.add(light2)
  return light

module.exports = init

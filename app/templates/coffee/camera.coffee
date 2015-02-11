'use strict'

init = ()->
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 10000)
  #camera.up.x = 0
  #camera.up.y = 0
  #camera.up.z = 1
  camera.position.y = -500
  camera.position.z = 200
  camera.lookAt(new THREE.Vector3(0, 0, 0))
  return camera

module.exports = init

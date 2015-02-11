'use strict'

ThreeScene = require('./scene')
ThreeCamera = require('./camera')
ThreeLight = require('./light')
ThreeObject = require('./object')

config =
  chartScale: 0.1

camera = null
scene = null
renderer = null
object = null

init = (data) ->
  camera = ThreeCamera()
  scene = ThreeScene()
  light = ThreeLight(scene)
  object = ThreeObject(scene, config, data)

  if window.WebGLRenderingContext
    renderer = new THREE.WebGLRenderer(
      antialias: true
    )
  else
    renderer = new THREE.CanvasRenderer()

  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setClearColor(0xffffff, 1.0)

  document.body.appendChild(renderer.domElement)

  renderer.render(scene, camera)
  return

animate = () ->
  camera.lookAt(new THREE.Vector3(200, 200, 0))
  #object.mesh.rotation.x += 0.01
  #object.mesh.rotation.y += 0.02

  renderer.clear()
  renderer.render(scene, camera)

  # note: three.js includes requestAnimationFrame shim
  requestAnimationFrame(animate)
  return


# mouse interaction (temp)
down = false
sy = 0
sz= 0

window.onmousedown = (ev) ->
  if ev.target is renderer.domElement
    down = true
    sy = ev.clientX
    sz = ev.clientY
  return

window.onmouseup = () ->
  down = false
  return

window.onmousemove = (ev) ->
  speed = 2
  if !down
    return
  if ev.target isnt renderer.domElement
    return
  dy = -(ev.clientX - sy)
  dz = -(ev.clientY - sz)
  console.log('dy:', dy)
  camera.position.y += dy * speed
  camera.position.z += dz * speed
  sy -= dy
  sz -= dz
  return


# initialize
init()

# initialize with some data
#dataUrl = 'data/something.json'
#
#get(dataUrl, (response) ->
#  init(response)
#  #loop()
#)


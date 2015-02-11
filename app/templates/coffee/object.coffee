'use strict'

_ = require('underscore')

initFloor = (scene) ->
  floors = []
  width = 50
  data = _.range(-50, 50)
  makeMesh = (color) ->
    geometry = new THREE.PlaneBufferGeometry(width, width, 1, 1)
    material = new THREE.MeshLambertMaterial(
      color: color
      ambient: color
    )
    return new THREE.Mesh(geometry, material)
    console.log 'geometry:', geometry

  makePlane = (i) ->
    data.forEach(do () ->
      x = i
      return (y) ->
        if (x + y) % 2 is 0
          plane = makeMesh(0x999999)
        else
          plane = makeMesh(0x4d4d4d)
        plane.position.x = x * width
        plane.position.y = y * width
        plane.position.z = 0
        #plane.receiveShadow = true
        scene.add(plane)
        floors.push(plane)
        return
    )
    return
  data.map(makePlane)
  return floors

initMesh = (scene, config, dataset) ->
  meshes = []
  xpos = []
  computeX = (item, i) ->
    start = -1 * (dataset.length / 2)
    x = start + (60 * i)
    xpos.push(x)
    return
  makeMesh = (item, i) ->
    height = item.value * config.chartScale
    geometry = new THREE.CylinderGeometry(25, 25, height)
    material = new THREE.MeshLambertMaterial(
      color: 0x1133ff,
      ambient: 0x1133ff
    )
    mesh = new THREE.Mesh(geometry, material)
    mesh.position.x = xpos[i]
    mesh.position.y = height / 2
    mesh.position.z = 200
    mesh.rotation.x = -(Math.PI / 2)
    #mesh.rotation.y = -(Math.PI / 2)
    scene.add(mesh)
    meshes.push(mesh)
    return

  dataset.map(computeX)
  dataset.map(makeMesh)
  return meshes


init = (scene, config, dataset) ->
  object = {}
  if dataset
    object.mesh = initMesh(scene, config, dataset)
  object.floor = initFloor(scene)
  return object

module.exports = init

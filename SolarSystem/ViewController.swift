//
//  ViewController.swift
//  SolarSystem
//
//  Created by Janusz Czornik on 17.07.2017.
//  Copyright © 2017 Janusz Czornik. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let solarSystem = SCNScene()
        let earth = CelesticalBody(name: "earth", texture: #imageLiteral(resourceName: "4096_earth"), radius: CGFloat(0.1), position: SCNVector3(x: 0, y: 0, z: -0.5))
        earth.RotateAction = SCNAction.rotate(by: 90 * CGFloat(.pi/180.0), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        earth.CreateSatelate(name: "Moon", texture: #imageLiteral(resourceName: "moonmap2k"), radius: 0.05, position: SCNVector3(x: 0, y: 0, z: -0.5), rotateFunction: nil, circulateFunction: nil)
        let moon = earth.childNode(withName: "Moon", recursively: true)
        moon?.geometry?.firstMaterial?.diffuse.textureComponents = .red
        
        solarSystem.rootNode.addChildNode(earth)
        sceneView.scene = solarSystem
        
//        let earthAction = SCNAction.rotate(by: 90 * CGFloat(.pi/180.0), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
//        // Set the scene to the view
//        sceneView.scene = earth
        
        
//        var repatAction = SCNAction.repeatForever(earthAction)
//        node.runAction(repatAction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

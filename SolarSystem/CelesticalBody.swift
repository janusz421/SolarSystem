//
//  CelesticalBody.swift
//  SolarSystem
//
//  Created by Janusz Czornik on 21.07.2017.
//  Copyright © 2017 Janusz Czornik. All rights reserved.
//


import Foundation
import SceneKit

class CelesticalBody : SCNNode {
    init(name: String, texture: UIImage, radius: CGFloat, position: SCNVector3?) {
        super.init()
        let sphere = SCNSphere(radius: radius)
        let material = SCNMaterial()
        material.diffuse.contents = texture
        sphere.materials = [material]
        self.geometry = sphere
        self.name = name
        self.position = position!
    }
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Public fields
    
    //Private fields
    private var Rotate : SCNAction? {
        willSet {
            if Rotate != nil {
                self.removeAction(forKey: CelesticalBody.RotateActionName)
            }
        }
        
        didSet {
            if Rotate != nil {
                self.runAction(SCNAction.repeatForever(Rotate!), forKey: CelesticalBody.RotateActionName)
            }
        }
    }
    
    private var Circulate : SCNAction? {
        willSet {
            if Circulate != nil {
                self.removeAction(forKey: CelesticalBody.CirculationActionName)
            }
        }
        
        didSet {
            if Circulate != nil {
                self.runAction(SCNAction.repeatForever(Circulate!), forKey: CelesticalBody.CirculationActionName)
            }
        }
    }
    
    private static let RotateActionName = "RatationAction"
    private static let CirculationActionName = "CirculationAction"
    
    //Protected fields
    
    //Public methods
    public var RotateAction : SCNAction? {
        get {
            return Rotate
        }
        
        set {
            Rotate = newValue
        }
    }
    
    public var CirculateAction: SCNAction? {
        get {
            return Circulate
        }
        
        set {
            Circulate = newValue
        }
    }
    
    public func CreateSatelate(name: String, texture: UIImage, radius: CGFloat, position: SCNVector3, rotateFunction: SCNAction?, circulateFunction: SCNAction?) {
        let satelate = CelesticalBody(name: name, texture: texture, radius: radius, position: position)
        self.addChildNode(satelate)
        if let inheritedRotation = self.RotateAction {
            satelate.runAction(inheritedRotation.reversed())
        }
        satelate.RotateAction = rotateFunction
    }
    
    public func OnTouch(_ sender: Any) {
        return
    }
    //Private methodt
}


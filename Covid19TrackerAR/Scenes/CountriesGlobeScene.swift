//
//  CountriesGlobeScene.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import SceneKit

class CountriesGlobeScene: SCNNode {
    
    struct Constants {
        static let sceneName = "art.scnassets/globe.scn"
    }
    
    override init() {
        super.init()
        guard let scene = SCNScene(named: Constants.sceneName) else { return }
        addChildNode(scene.rootNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func findCountryPinNode(countryISO3: String) -> SCNNode? {
        return self.childNode(withName: countryISO3, recursively: false)
    }
}

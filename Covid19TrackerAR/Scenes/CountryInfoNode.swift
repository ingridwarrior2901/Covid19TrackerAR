//
//  CountryInfoNode.swift
//  Covid19TrackerAR
//
//  Created by Cris on 1/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import SceneKit

class CountryInfoNode: SCNNode {
    
    //MARK: - Properties
    var countryNameNode: SCNText?
    var countryCasesNode: SCNText?
    var countryDeathsNode: SCNText?
    var countryRecoveredNode: SCNText?
    var countryActiveNode: SCNText?
    var countryImagePlane: SCNPlane?
    
    //MARK: - Constants
    struct Constants {
        static let sceneName = "art.scnassets/CountryInfo.scn"
        static let countryNameText = "CountryName"
        static let countryCasesText = "CountryCases"
        static let countryDeathsText = "CountryDeaths"
        static let countryRecoveredText = "CountryRecovered"
        static let countryActiveText = "CountryActive"
        static let countryImage = "CountryImage"
    }
    
    override init() {
        super.init()
        guard let scene = SCNScene(named: Constants.sceneName) else { return }
        
        addChildNode(scene.rootNode)
        
        guard let countryNameCases = scene.rootNode.childNode(withName: Constants.countryNameText, recursively: false)?.geometry as? SCNText,
            let countryCases = scene.rootNode.childNode(withName: Constants.countryCasesText, recursively: false)?.geometry as? SCNText,
            let countryDeaths = scene.rootNode.childNode(withName: Constants.countryDeathsText, recursively: false)?.geometry as? SCNText,
            let countryRecovered = scene.rootNode.childNode(withName: Constants.countryRecoveredText, recursively: false)?.geometry as? SCNText,
            let countryActive = scene.rootNode.childNode(withName: Constants.countryActiveText, recursively: false)?.geometry as? SCNText,
            let countryImage = scene.rootNode.childNode(withName: Constants.countryImage, recursively: false)?.geometry as? SCNPlane else {
                return
        }
        
        countryNameNode = countryNameCases
        countryCasesNode = countryCases
        countryDeathsNode = countryDeaths
        countryRecoveredNode = countryRecovered
        countryActiveNode = countryActive
        countryImagePlane = countryImage
    }
    
    func configCountryInfo(viewModel: CountryViewModel) {
        countryNameNode?.string = viewModel.countryName
        countryCasesNode?.string = viewModel.countryCases
        countryDeathsNode?.string = viewModel.countryDeaths
        countryRecoveredNode?.string = viewModel.countryRecovered
        countryActiveNode?.string = viewModel.countryActive
        
        viewModel.loadCountryImage { [weak self] (image) in
            guard let flagImage = image else { return }
            DispatchQueue.main.async() {
                self?.countryImagePlane?.firstMaterial?.diffuse.contents = flagImage
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ViewController.swift
//  Covid19TrackerAR
//
//  Created by Cris on 26/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class CountryARViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var loadingView: UIView!
    
    let countryServices = CountryServices()
    var globeNode: CountriesGlobeScene?
    var countryInfoNode: CountryInfoNode?
    var globeYRotation: Float = 0.0
    var countries = [CountryModel]()
    
    //MARK: - Constants
    struct Constants {
        static let globeZPadding: Float = 0.29
        static let countryInfoScale: Float = 0.1
        static let countryInfoPadding: Float = 0.1
        static let countryInfoRotationY = -25
        static let rotationSpeed: Double = 0.5
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAREnvironment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

//MARK: - Public Methods

extension CountryARViewController {
    
    @IBAction func didTapReload(_ sender: Any) {
        globeNode?.removeFromParentNode()
        countryInfoNode?.removeFromParentNode()
        loadCountries()
        setupGesture()
        addNodeToScene()
    }
}

//MARK: - Private Methods

fileprivate extension CountryARViewController {
    
    func setupAREnvironment() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        loadCountries()
        setupNodes()
        setupGesture()
        addNodeToScene()
    }
    
    func loadCountries() {
        countryServices.fetchCountriesInfo { [weak self] (countries) in
            DispatchQueue.main.async {
                self?.countries = countries
                self?.loadingView.isHidden = true
            }
        }
    }
    
    func setupNodes() {
        globeNode = CountriesGlobeScene()
        countryInfoNode = CountryInfoNode()
    }
    
    func addNodeToScene() {
        guard let pointOfView = sceneView.pointOfView, let globe = globeNode, !sceneView.scene.rootNode.childNodes.contains(globe)  else { return }
        let position = pointOfView.position
        globe.position = SCNVector3(position.x, position.y, position.z - Constants.globeZPadding)
        sceneView.scene.rootNode.addChildNode(globe)
    }
    
    func setupGesture() {
        let tapGestureRecognizers = UITapGestureRecognizer(target: self, action: #selector(globeTapped))
        sceneView.addGestureRecognizer(tapGestureRecognizers)
        
        let panGestureRecognizers = UIPanGestureRecognizer(target: self, action:  #selector(globePanRotate))
        sceneView.addGestureRecognizer(panGestureRecognizers)
    }
}

//MARK: - Gesture Methods

extension CountryARViewController {
    
    @objc func globeTapped(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else { return }
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation, options: nil)
        
        guard let result = hitTest.first,
            let nodeName = result.node.name,
            let selectedCountry = countries.first(where: { $0.countryInfo?.iso3 == nodeName}),
            let globe = globeNode,
            let countryInfo = countryInfoNode else {
                return
        }
        
        countryInfo.configCountryInfo(viewModel: CountryViewModel(model: selectedCountry))
        
        if !sceneView.scene.rootNode.contains(countryInfo) {
            countryInfo.scale = SCNVector3(Constants.countryInfoScale,
                                           Constants.countryInfoScale,
                                           Constants.countryInfoScale)
            countryInfo.position = SCNVector3(globe.position.x + Constants.countryInfoPadding,
                                              globe.position.y - Constants.countryInfoPadding,
                                              globe.position.z + Constants.countryInfoPadding)
            countryInfo.eulerAngles = SCNVector3(0,
                                                 Constants.countryInfoRotationY.degreesToRadians,
                                                 0)
            sceneView.scene.rootNode.addChildNode(countryInfo)
        }
    }
    
    @objc func globePanRotate(_ sender: UIPanGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView, let globe = globeNode else {
            return
        }
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation)
        if !hitTest.isEmpty {
            let gestureTranslation = sender.translation(in: sender.view!)
            var rotationY: Float = 0.0
            switch sender.state {
            case .changed:
                rotationY = Float(gestureTranslation.x.degreesToRadians * Constants.rotationSpeed)
                rotationY += globeYRotation
                globe.eulerAngles.y = Float(rotationY)
            case .ended:
                globeYRotation = globe.eulerAngles.y
            default: break
            }
        }
    }
}

//MARK: - ARSCNViewDelegate

extension CountryARViewController: ARSCNViewDelegate {
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        //TODO:
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        //TODO:
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        //TODO:
    }
}

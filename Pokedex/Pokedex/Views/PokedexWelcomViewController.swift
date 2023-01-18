//
//  PokedexWelcomViewController.swift
//  Pokedex
//
//  Created by Philippe Santos on 17/01/23.
//

import UIKit
import Flutter

class PokedexWelcomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFlutterPressed(_ sender: Any) {
        let flutterViewController =
//        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        FlutterViewController(project: nil, initialRoute: "/pokemon/detail?id=\(11)&auth=asdfasd", nibName: nil, bundle: nil)
        
        flutterViewController.modalTransitionStyle = .crossDissolve
        flutterViewController.modalPresentationStyle = .fullScreen
       
        present(flutterViewController, animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  Pokedex
//
//  Created by Philippe Santos on 16/01/23.
//

import UIKit
import Flutter

class PokedexSearchView: UITableViewController, UISearchBarDelegate {
    let controller = PokedexSearchController()
    
    let secretKey = "Avocato3551"

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.updateUI = updateUI
        searchBarInput.delegate = self
        
        controller.fetchAllPokemons()
    }

    func updateUI(){
        tableView.reloadData()
    }

    @IBOutlet weak var searchBarInput: UISearchBar!
}

extension PokedexSearchView {
    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexListCell", for: indexPath)
        cell.textLabel?.text = controller.pokemons[indexPath.row].name
        
        return cell
    }
}

extension PokedexSearchView {
    //MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemon = controller.pokemons[indexPath.row]
       
        let flutterViewController = FlutterViewController(
            project: nil,
            initialRoute: "/pokemon/detail?id=\(pokemon.id)&auth=asdfasd",
            nibName: nil,
            bundle: nil
        )
        
        //MARK: - add channels here
        let secretsChannel = FlutterMethodChannel(name: "br.edu.pss.pokedex/secrets", binaryMessenger: flutterViewController.binaryMessenger)
        
        //MARK: - register channel's handler here
        secretsChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "getSecretKey" {
                result(self.secretKey)
            }
            result(FlutterMethodNotImplemented)
        })
        
        flutterViewController.modalTransitionStyle = .crossDissolve
        flutterViewController.modalPresentationStyle = .fullScreen
       
        present(flutterViewController, animated: true, completion: nil)
    }
}

extension PokedexSearchView {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        controller.filterPokemonByText(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

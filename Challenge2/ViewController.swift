//
//  ViewController.swift
//  Challenge2
//
//  Created by Luca Hummel on 07/07/21.
//

import UIKit

class ViewController: UITableViewController {
    var produts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My shopping list"
        
        // Adicionar mais de uma rightButton
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        navigationItem.rightBarButtonItems = [share, add]
        
        // add botao esquerda
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshList))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Produto", for: indexPath)
        cell.textLabel?.text = produts[indexPath.row]
        return cell
    }
    
    // Adicionar elemento na TableView
    
    @objc func addProduct() {
        let ac = UIAlertController(title: "Add product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let newProduct = ac?.textFields?[0].text else {return}
            self?.submit(newProduct: newProduct)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(newProduct: String) {
        if newProduct == ""{
            let ac = UIAlertController(title: "Error", message: "You can't add a empty product", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        } else {
            produts.insert(newProduct, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        
    }
    
    // Compartilhar lista

    @objc func shareList() {
        let list = produts.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    // Refresh list
    
    @objc func refreshList() {
        produts = [String]()
        tableView.reloadData()
    }

}


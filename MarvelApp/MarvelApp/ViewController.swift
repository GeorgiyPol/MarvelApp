//
//  ViewController.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import UIKit

class ViewController: UIViewController {

    private let urlMarvel = "https://gateway.marvel.com/v1/public/characters?ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7"
    @IBOutlet weak var tableView: UITableView!
    var marvel: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        
        self.tableView.register(UINib(nibName: "MarvelTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "MarvelTableViewCell")
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.marvel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelTableViewCell", for: indexPath) as? MarvelTableViewCell {
            cell.marvelCharacter = self.marvel[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

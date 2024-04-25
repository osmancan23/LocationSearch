//
//  PlaceListViewController.swift
//  Location-Search
//
//  Created by Osmancan Akagündüz on 3.04.2024.
//

import UIKit

class PlaceListViewController: UIViewController {
    //var placeArray = [Place]()
    @IBOutlet weak var searchbarView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaceCell.nib(), forCellReuseIdentifier: PlaceCell.identifier)
        tableView.separatorColor = .clear
        searchbarView.delegate = self
    }
}

//MARK: - TableView Delegate and DataSource
extension PlaceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as! PlaceCell
        cell.placeNameLabel.text = "Place \(indexPath.row)"
        cell.placeDetailImage.image = .randomCafe
        return cell
    }
}

extension PlaceListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: Arraydeki elemanlardan isim araması yapıp tableView'ı reload edicek
    }
}

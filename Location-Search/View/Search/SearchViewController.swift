import UIKit
import GoogleMaps
import GooglePlaces

class SearchViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    
    let data = [[SearchMenuModel(name: "Konumunuz", image: "location"),SearchMenuModel(name: "Haritadan seç", image: "rectangle.and.hand.point.up.left"),], [SearchMenuModel(name: "İstanbul Söğütlüçeşme", image: "clock"),SearchMenuModel(name: "İstanbul Söğütlüçeşme", image: "clock"),SearchMenuModel(name: "İstanbul Söğütlüçeşme", image: "clock"),SearchMenuModel(name: "İstanbul Söğütlüçeşme", image: "clock"),SearchMenuModel(name: "İstanbul Söğütlüçeşme", image: "clock"),]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
     
    }

  
}


extension SearchViewController : UISearchBarDelegate {
   
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search button clicked with text: \(searchBar.text ?? "")")
        places.removeAll()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        places.removeAll()
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            places.removeAll()
            tableView.reloadData()
          return
        }
        
        GooglePlacesManeger.shared.findPlaces(query: query) { result in
          switch result{
          case .success(let places):
            self.tableView.isHidden = false
            self.places = places
            self.tableView.reloadData()
            
            
            
          case .failure(let error):
            print(error)
          }
        }
        tableView.reloadData()
    }
    
    
    
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.handleCell(model: data[indexPath.section][indexPath.row])
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return  section == 0 ? "" : "Geçmiş"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = (view as! UITableViewHeaderFooterView)
        headerView.textLabel?.font.withSize(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.isHidden = true
        
      /*  let place = places[indexPath.row]
        GooglePlacesManeger.shared.resolveLocation(for: place) {[weak self] result in
          
            switch result {
              
          case .success(let coordinate ):
            
              DispatchQueue.main.async{
              self?.delegate?.didTapPlaceWithCoordinate(with: coordinate)
            }
          case .failure(let error):
            print(error)
          }
        }*/
        
    }
}

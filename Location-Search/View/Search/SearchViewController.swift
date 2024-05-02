import UIKit
import GoogleMaps
import GooglePlaces

protocol SearchViewControllerDelegate: AnyObject {
    func didTapPlaceWithCoordinate(with coordinates: CLLocationCoordinate2D)
}

private var reuseIdentifier = "cell"
class SearchViewController: UIViewController {
    // MARK: - Properties
    let headerViewHeight: CGFloat = 150 // Header view height
    let cellHeight: CGFloat = 100 // Height of each cell in the table view
    
    private var places: [Place] = []
    private var history : [Place] = []
    weak var delegate : SearchViewControllerDelegate?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let separatorView : UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray // Adjust color as desired
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
   
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.systemGray
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let  headerImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location.circle"))
        imageView.contentMode = .scaleAspectFit // Maintain aspect ratio
        imageView.tintColor = .black
        imageView.frame = CGRect(x: 20, y: 90, width: 38, height: 33) // Adjust width and height for desired size
        return imageView
    }()
    lazy var currentLocationLabel = {
        let label = UILabel()
        label.text = "Header Label"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    
    
}
// MARK: - Helpers
extension SearchViewController{
    private func style(){

        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        view.addSubview(headerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        headerView.addGestureRecognizer(tapGesture)
        headerView.addSubview(headerImageView)
        headerView.addSubview(currentLocationLabel)

        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        tableView.register(SearchBarTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(separatorView)


        
    }
    private func layout(){
        headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.navigationController?.navigationBar.frame.height ?? 0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
        
        currentLocationLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 30).isActive = true
        currentLocationLabel.leadingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: 20).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true // Set height to 10 for the line
        
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    @objc func headerTapped() {

        print("Header tapped")
    }
}
// MARK: - UITableViewDataSource && UITableViewDelegate
extension SearchViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count // Number of rows in the table view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight // Height of each cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        var place : String?
        if let cell = cell as? SearchBarTableViewCell {
            place = places[indexPath.row].name // Assuming places holds your data source
            var searchTableViewModel = SearchTableViewModel(locationName: place ?? "unknown place", distance: "11km")
            cell.searchTableViewModel = searchTableViewModel
            
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.isHidden = true
        
        let place = places[indexPath.row]
        GooglePlacesManeger.shared.resolveLocation(for: place) {[weak self] result in
          
            switch result {
              
          case .success(let coordinate ):
            
              DispatchQueue.main.async{
              self?.delegate?.didTapPlaceWithCoordinate(with: coordinate)
            }
          case .failure(let error):
            print(error)
          }
        }
        
    }
}
extension SearchViewController : UISearchBarDelegate{
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

//
//  TableViewControllerMain.swift
//  Proyecto
//
//  Created by Luis González Rodríguez on 16/1/23.
//

import UIKit

class TableViewControllerMain: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    let searchController = UISearchController()
    @IBOutlet weak var EjerTableView: UITableView!
    
    var shapeList = [Rutinas]()
    var filteredShapes = [Rutinas]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initList()
        initSearchController()
    }
    
    func initSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Piernas", "Brazos", "Espalda", "Abdomen", "Cardio"]
        searchController.searchBar.delegate = self
    }
    
    func initList()
    {
        let circle = Rutinas(id: "0", name: "Piernas 1")
        shapeList.append(circle)
        
        let square = Rutinas(id: "1", name: "Brazos 1")
        shapeList.append(square)
        
        let octagon = Rutinas(id: "2", name: "Espalda 1")
        shapeList.append(octagon)
        
        let rectangle = Rutinas(id: "3", name: "Abdomen 1")
        shapeList.append(rectangle)
        
        let triangle = Rutinas(id: "4", name: "Cardio 1")
        shapeList.append(triangle)
        
        let circle2 = Rutinas(id: "5", name: "Piernas 2")
        shapeList.append(circle2)
        
        let square2 = Rutinas(id: "6", name: "Brazos 2")
        shapeList.append(square2)
        
        let octagon2 = Rutinas(id: "7", name: "Espalda 2")
        shapeList.append(octagon2)
        
        let rectangle2 = Rutinas(id: "8", name: "Abdomen 2")
        shapeList.append(rectangle2)
        
        let triangle2 = Rutinas(id: "9", name: "Cardio 2")
        shapeList.append(triangle2)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(searchController.isActive)
        {
            return filteredShapes.count
        }
        return shapeList.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! CeldaTablaMain
        
        let thisShape: Rutinas!
        
        if(searchController.isActive)
        {
            thisShape = filteredShapes[indexPath.row]
        }
        else
        {
            thisShape = shapeList[indexPath.row]
        }
        
        
        tableViewCell.shapeName.text = thisShape.id + " " + thisShape.name
        
        return tableViewCell
    }
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "detailSegue")
        {
            let indexPath = self.EjerTableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? MainViewController
            
            self.EjerTableView.deselectRow(at: indexPath, animated: true)
        }
    }

    
    
    //Actualizacion
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    
    
    
    //Filtro
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All")
    {
        filteredShapes = shapeList.filter
        {
            rutinas in
            let scopeMatch = (scopeButton == "All" || rutinas.name.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = rutinas.name.lowercased().contains(searchText.lowercased())
                
                return scopeMatch && searchTextMatch
            }
            else
            {
                return scopeMatch
            }
        }
        EjerTableView.reloadData()
    }
}

//
//  ViewController.swift
//  SearchBarProject
//
//  Created by My Mac on 17/09/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating {
    
    

    @IBOutlet weak var searchText: UISearchBar!
    
    @IBOutlet weak var animalCollectionView: UICollectionView!
    
    var images = ["Camel","Cat","Chitaa","Cow","Deer","Dog","Elephant","Frog","Jiraf","Kangaroo","Lizard","Monkey","Panda","Parrot","Peaflow","Rabit","Rat","Snake","Squirrel","Tiger","Zebra"]
    
    var names = ["Camel","Cat","Chitaa","Cow","Deer","Dog","Elephant","Frog","Jiraf","Kangaroo","Lizard","Monkey","Panda","Parrot","Peaflow","Rabit","Rat","Snake","Squirrel","Tiger","Zebra"]
    
    var searching = false
    var searcheddata = [String]()
    
    var filterData = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData = names
        configureSearchController()
    }

    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Image by Name"
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching
        {
            return searcheddata.count
        }
        else
        {
            return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.animalCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! animalCollectionViewCell

        if searching
        {
            cell.imageView.image = UIImage(named: searcheddata[indexPath.row])
            cell.nameLabel.text = searcheddata[indexPath.row]
        }
        else
        {
            cell.imageView.image = UIImage(named: images[indexPath.item])
            cell.nameLabel.text = names[indexPath.row]
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionwidth = collectionView.bounds.width
        return CGSize(width: collectionwidth/2, height: collectionwidth/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty
        {
            searching = true
            searcheddata.removeAll()
            for image in images
            {
                if image.lowercased().contains(searchText.lowercased())
                {
                    searcheddata.append(image)
                }
            }
        }
        else
        {
            searching = false
            searcheddata.removeAll()
            searcheddata = images
        }
        animalCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searcheddata.removeAll()
        animalCollectionView.reloadData()
    }
    
}

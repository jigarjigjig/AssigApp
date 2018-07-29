//
//  searchViewController.swift
//  AsgmntApp
//
//  Created by Jigar on 28/07/18.
//  Copyright © 2018 Jigar. All rights reserved.
//

import UIKit



protocol searchResultDelegate {
    func onSearchResultLoaded();
}


class searchViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate ,searchResultDelegate,UISearchBarDelegate{
    func onSearchResultLoaded() {
        
        DispatchQueue.main.async {
            self.searchResultTableView.reloadData();
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var noResult : Bool = false ;
    
    @IBOutlet weak var wikiLabel: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = searchResult.searchResult?.query?.pages?.count{
            print(count)
            if(count == 0){
                noResult = true;
                if(searchBar.text?.count == 0){
                    return 0 ;
                }
                return 1;
                
            }else{
                noResult = false;
            }
            return count
        }
        if(searchBar.text?.count == 0){
            return 0 ;
        }else{
            noResult = true;
            return 1 ;
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 0){
            wikiLabel.isHidden = false;
            noResult = false;
        }else{
            wikiLabel.isHidden = true;
        }
        searchResult.makeRequest(request: searchText);
    }
    
    
    
    
    // var tips:[Tip] = [];
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchResultTableView.separatorStyle = .singleLine
        searchResultTableView.layoutMargins = UIEdgeInsets.zero
        searchResultTableView.separatorInset = UIEdgeInsets.zero
        searchBar.delegate = self;
        searchResult.searchResultDelegate = self;
        searchBar.text = "Sachin";
        searchResult.makeRequest(request: searchBar.text!);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if noResult == true {
            let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "noResultFound", for: indexPath) as! noResultFoundViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            return cell
            
        }else{
            let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "resultDetailCell", for: indexPath) as! searchResultViewCell
            
            cell.setpageInfo(page: (searchResult.searchResult?.query?.pages![indexPath.item])!)
            cell.layoutMargins = UIEdgeInsets.zero
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let LiveViewStoryboard = UIStoryboard(name:"Main",bundle: nil)
        let vc = LiveViewStoryboard.instantiateViewController(withIdentifier: "myWebViewID") as! webPageViewController
        if let pageInfo = searchResult.searchResult?.query?.pages![indexPath.item] {
            if let pageID = pageInfo.pageid {
                vc.stringURL = "http://en.wikipedia.org/?curid=" + "\(String(describing: pageID))";
            }
            vc.strTitle = pageInfo.title;
            vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        }
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
}


//
//  searchResultViewCell.swift
//  AsgmntApp
//
//  Created by Jigar on 29/07/18.
//  Copyright © 2018 Jigar. All rights reserved.
//

import Foundation
import UIKit

class searchResultViewCell: UITableViewCell {
    
    var pages : Pages? ;
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var shortDesc: UILabel!
    
    
    
    func setpageInfo(page : Pages) -> Void {
        pages = page;
        title.text = pages?.title
        shortDesc.text = pages?.terms?.description![0]
        if let thumbnailURL = pages?.thumbnail?.source {
            if let url = URL(string: thumbnailURL) {
                photo.contentMode = .scaleAspectFit
                downloadImage(url: url);
                
            }
        }else{
            self.photo.image = #imageLiteral(resourceName: "wiki")
        }
        
    }
    
    
    func downloadImage(url: URL) ->Void {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                
                if let data = cache.getValue(for: url.absoluteString){
                    self.photo.image = UIImage(data: data)
                }
                
                return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                self.photo.image = UIImage(data: data)
                cache.setValue(data, for: url.absoluteString)
            }
            }.resume()
        
    }
    
}



class noResultFoundViewCell: UITableViewCell {
    
    
    
}



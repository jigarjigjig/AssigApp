//
//  SearchResultManager
//  JsonOpr
//
//  Created by Jigar on 28/07/18.
//  Copyright © 2018 Jigar. All rights reserved.
//


import Foundation




let searchResult = SearchResultManager();

let cache = CacheLRU<String, Data>(capacity: 1000)

class SearchResultManager {
    
    var userCacheURL: URL?
    
    let userCacheQueue = OperationQueue()
    
    var dataTask: URLSessionDataTask?
    
    var searchResult : Json4Swift_Base?;
    
    var searchResultDelegate : searchResultDelegate?
    
    
    func makeRequest(request : String) -> Void {
        
        let _request = request.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ;
        var queryUrl : String = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=" + _request! + "&gpslimit=10";
       
        guard let gitUrl = URL(string: queryUrl) else { return }
        dataTask?.cancel()
        dataTask =  URLSession.shared.dataTask(with: gitUrl) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                print("DataTask error: " + error.localizedDescription);
                if let data = cache.getValue(for: queryUrl){
                    self.searchResult = self.jsonDecode(data: data);
                }else{
                    self.searchResult = nil;
                    self.searchResultDelegate?.onSearchResultLoaded();
                }
                self.searchResultDelegate?.onSearchResultLoaded();
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                cache.setValue(data, for: queryUrl)
                self.searchResult = self.jsonDecode(data: data);
                self.searchResultDelegate?.onSearchResultLoaded();
            }
        }
        dataTask?.resume()
    }
    
    func jsonDecode(data : Data) -> Json4Swift_Base {
        var gitData : Json4Swift_Base? = nil;
        do {
            let decoder = JSONDecoder()
            gitData = try decoder.decode(Json4Swift_Base.self, from: data)
            return gitData!;
        } catch let err {
            print("Err", err)
        }
        
        return gitData!;
    }
    
    
    
}


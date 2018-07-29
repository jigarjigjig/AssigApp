//
//  JsonObject.swift
//  AsgmntApp
//
//  Created by Jigar on 28/07/18.
//  Copyright © 2018 Jigar. All rights reserved.
//

import Foundation





struct Continue : Codable {
    let gpsoffset : Int?
    let `continue` : String?
    
    enum CodingKeys: String, CodingKey {
        
        case gpsoffset = "gpsoffset"
        case `continue` = "continue"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gpsoffset = try values.decodeIfPresent(Int.self, forKey: .gpsoffset)
        `continue` = try values.decodeIfPresent(String.self, forKey: .continue)
    }
    
}

struct Json4Swift_Base : Codable {
    let batchcomplete : Bool?
    let `continue` : Continue?
    let query : Query?
    
    enum CodingKeys: String, CodingKey {
        
        case batchcomplete = "batchcomplete"
        case `continue` = "continue"
        case query = "query"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        batchcomplete = try values.decodeIfPresent(Bool.self, forKey: .batchcomplete)
        `continue` = try values.decodeIfPresent(Continue.self, forKey: .`continue`)
        query = try values.decodeIfPresent(Query.self, forKey: .query)
    }
    
}

struct Pages : Codable {
    let pageid : Int?
    let ns : Int?
    let title : String?
    let index : Int?
    let thumbnail : Thumbnail?
    let terms : Terms?
    
    enum CodingKeys: String, CodingKey {
        
        case pageid = "pageid"
        case ns = "ns"
        case title = "title"
        case index = "index"
        case thumbnail = "thumbnail"
        case terms = "terms"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pageid = try values.decodeIfPresent(Int.self, forKey: .pageid)
        ns = try values.decodeIfPresent(Int.self, forKey: .ns)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        index = try values.decodeIfPresent(Int.self, forKey: .index)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        terms = try values.decodeIfPresent(Terms.self, forKey: .terms)
    }
    
}


struct Query : Codable {
    let redirects : [Redirects]?
    let pages : [Pages]?
    
    enum CodingKeys: String, CodingKey {
        
        case redirects = "redirects"
        case pages = "pages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        redirects = try values.decodeIfPresent([Redirects].self, forKey: .redirects)
        pages = try values.decodeIfPresent([Pages].self, forKey: .pages)
    }
    
}

struct Redirects : Codable {
    let index : Int?
    let from : String?
    let to : String?
    let tofragment : String?
    
    enum CodingKeys: String, CodingKey {
        
        case index = "index"
        case from = "from"
        case to = "to"
        case tofragment = "tofragment"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        index = try values.decodeIfPresent(Int.self, forKey: .index)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        tofragment = try values.decodeIfPresent(String.self, forKey: .tofragment)
    }
    
}


struct Terms : Codable {
    let description : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent([String].self, forKey: .description)
    }
    
}

struct Thumbnail : Codable {
    let source : String?
    let width : Int?
    let height : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case source = "source"
        case width = "width"
        case height = "height"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }
    
}


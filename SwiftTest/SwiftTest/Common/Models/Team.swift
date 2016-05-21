//
//  Team.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright © 2016 Sports Illustrated. All rights reserved.
//

import ObjectMapper

class Team: Mappable {
    
    var teamID: Int?
    var name: String?
    var highlightColor: String?
    var players:[Player]?

    init() {}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        teamID <- map["Id"]
        name <- map["Name"]
        highlightColor <- map["Settings.HighlightColor"]
        players <- map["Players"]
    }
    
    
}

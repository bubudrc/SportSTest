//
//  Player.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright © 2016 Sports Illustrated. All rights reserved.
//

import ObjectMapper

class Player: Mappable {
    
    var playerID: Int?
    var jerseyNumber: String?
    var firstName: String?
    var lastName: String?
    var imageURL: String?
    
    init() {}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        playerID <- map["Id"]
        jerseyNumber <- map["JerseyNumber"]
        firstName <- map["Person.FirstName"]
        lastName <- map["Person.LastName"]
        imageURL <- map["Person.ImageUrl"]
    }


}

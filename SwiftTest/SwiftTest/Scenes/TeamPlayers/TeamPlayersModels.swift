//
//  TeamPlayersModels.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright (c) 2016 Sports Illustrated. All rights reserved.
//

import UIKit

struct TeamPlayersRequest {}

struct TeamPlayersResponse {
    var team:Team
}

struct TeamPlayersViewModel {
    struct DisplayedPlayer {
        var playerID: Int?
        var imageURL: String?
        var firstName: String
        var lastName: String!
        var jerseyNumber: String!
        var teamID: Int?
    }
    
    struct DisplayedTeamPlayer {
        var teamID: Int?
        var name: String?
        var highlightColor: String?
        var players:[DisplayedPlayer]?
    }
    
    var displayedPlayers: [DisplayedPlayer]
    var displayedTeam: DisplayedTeamPlayer


}

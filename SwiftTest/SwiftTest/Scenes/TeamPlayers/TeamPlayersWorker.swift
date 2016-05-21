//
//  TeamPlayersWorker.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright (c) 2016 Sports Illustrated. All rights reserved.
//

import UIKit

class TeamPlayersWorker {
    lazy var teamManager = NetworkManager()

    // MARK: Business Logic
    func getTeamPlayers(success: Team -> Void) {
        self.teamManager.getTeam(success)
    }
    
    func getPlayerResponse(withTeamID teamID:Int?, andPlayerID playerID:Int?, andPlayerFirstName playerFirstName:String?, andPlayerLastName playerLastName:String?, andResult success: Bool -> Void) {
        
        self.teamManager.getPlayerResponse(withTeamID: teamID, andPlayerID: playerID, andPlayerFirstName: playerFirstName, andPlayerLastName: playerLastName, andResult: success)
    }
}

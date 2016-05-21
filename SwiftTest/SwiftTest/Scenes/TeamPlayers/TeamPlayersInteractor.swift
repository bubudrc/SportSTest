//
//  TeamPlayersInteractor.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright (c) 2016 Sports Illustrated. All rights reserved.
//

import UIKit

protocol TeamPlayersInteractorInput {
    func getTeamPlayers()
    func getResultForTeamPlayerSelected(viewModel: TeamPlayersViewModel.DisplayedPlayer)
}

protocol TeamPlayersInteractorOutput {
    func presentTeamPlayers(response: TeamPlayersResponse)
    func presentResultTeamPlayerSelected(response: Bool)
}

class TeamPlayersInteractor: TeamPlayersInteractorInput {
    var output: TeamPlayersInteractorOutput!
    lazy var worker = TeamPlayersWorker()
    // MARK: Business logic

    func getTeamPlayers() {
        worker.getTeamPlayers ({ (team: Team) in
            let response = TeamPlayersResponse(team: team)
            self.output.presentTeamPlayers(response)
        })
    }
    
    func getResultForTeamPlayerSelected(viewModel: TeamPlayersViewModel.DisplayedPlayer) {
        let player = viewModel
        
        worker.getPlayerResponse(withTeamID: player.teamID, andPlayerID: player.playerID, andPlayerFirstName: player.firstName, andPlayerLastName: player.lastName, andResult: { (result: Bool) in
            self.output.presentResultTeamPlayerSelected(result)
        })
    }
}

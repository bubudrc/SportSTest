//
//  TeamPlayersPresenter.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright (c) 2016 Sports Illustrated. All rights reserved.
//

import UIKit

protocol TeamPlayersPresenterInput {
    func presentTeamPlayers(response: TeamPlayersResponse)
    func presentResultTeamPlayerSelected(response: Bool)
}

protocol TeamPlayersPresenterOutput: class {
    func displayTeamPlayers(viewModel: TeamPlayersViewModel)
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
}

class TeamPlayersPresenter: TeamPlayersPresenterInput {
    weak var output: TeamPlayersPresenterOutput!

    // MARK: Presentation logic

    func presentTeamPlayers(response: TeamPlayersResponse) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        var displayedTeamPlayers: [TeamPlayersViewModel.DisplayedPlayer] = []

        if let players = response.team.players where !players.isEmpty {
            for teamPlayer in players {
                let first_name = teamPlayer.firstName ?? ""
                let last_name = teamPlayer.lastName ?? ""
                let jersey_number =  teamPlayer.jerseyNumber ?? "0"
                
                let diplayedPlayer = TeamPlayersViewModel.DisplayedPlayer(playerID: teamPlayer.playerID, imageURL: teamPlayer.imageURL, firstName: first_name, lastName: last_name, jerseyNumber: jersey_number, teamID: response.team.teamID)
                    
                displayedTeamPlayers.append(diplayedPlayer)
            }
        }
        
        
        let diplayedTeamPlayer = TeamPlayersViewModel.DisplayedTeamPlayer(teamID: response.team.teamID, name: response.team.name, highlightColor: response.team.highlightColor, players: displayedTeamPlayers)

        let viewModel = TeamPlayersViewModel(displayedPlayers: displayedTeamPlayers, displayedTeam: diplayedTeamPlayer)
        output.displayTeamPlayers(viewModel)
    }
    
    func presentResultTeamPlayerSelected(response: Bool) {
        var message = "Your selected player fails"
        if response {
            message = "Your selected player is correct"
            output.displaySuccessMessage(message)
        } else {
            output.displayErrorMessage(message)
        }

    }
}

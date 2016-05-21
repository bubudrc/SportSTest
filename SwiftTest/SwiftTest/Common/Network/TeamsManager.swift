//
//  TeamsManager.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright © 2016 Sports Illustrated. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireObjectMapper

private let teamEndpoint = "/team.json"
private let teamSuccessEndpoint = "/tapped.php?"


extension NetworkManager {
    func getTeam(success: Team -> Void) {
        
        Alamofire.request(.GET, self.baseUrl + teamEndpoint).responseObject {
            (response: Response<Team, NSError>) in
            success(response.result.value!)
        }
    }
    
    func getPlayerResponse(withTeamID teamID:Int?, andPlayerID playerID:Int?, andPlayerFirstName playerFirstName:String?, andPlayerLastName playerLastName:String?, andResult success: Bool -> Void) {
        
        let URLtoCall = self.baseUrl + teamSuccessEndpoint + "teamid=\(teamID!)&playerid=\(playerID!)&firstname=\(playerFirstName!)&lastname=\(playerLastName!)"

        Alamofire.request(.GET, URLtoCall).responseString{
            (response: Response<String, NSError>) in
            success(response.result.value! == "OK")
        }
    }
}

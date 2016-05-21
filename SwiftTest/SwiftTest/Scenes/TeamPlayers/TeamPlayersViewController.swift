//
//  TeamPlayersViewController.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright (c) 2016 Sports Illustrated. All rights reserved.
//

import UIKit

protocol TeamPlayersViewControllerInput {
    func displayTeamPlayers(viewModel: TeamPlayersViewModel)
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
}

protocol TeamPlayersViewControllerOutput {
    func getTeamPlayers()
    func getResultForTeamPlayerSelected(viewModel: TeamPlayersViewModel.DisplayedPlayer)
}

class TeamPlayersViewController: UICollectionViewController, TeamPlayersViewControllerInput {
    var output: TeamPlayersViewControllerOutput!
    var router: TeamPlayersRouter!
    
    
    let headerIdentifier = "TeamHeaderIdentifier"
    let cellIdentifier = "PlayerCellIdentifier"
    let columnsNumber:CGFloat = 3
    
    var team = TeamPlayersViewModel.DisplayedTeamPlayer ()
    var players:[TeamPlayersViewModel.DisplayedPlayer] = []
    

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        TeamPlayersConfigurator.sharedInstance.configure(self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.getTeamPlayers()
    }

    // MARK: Display logic

    func displayTeamPlayers(viewModel: TeamPlayersViewModel) {
        self.players = viewModel.displayedPlayers
        self.team = viewModel.displayedTeam
        self.collectionView?.reloadData()
    }
    
    func displaySuccessMessage(message: String) {
        self.showSuccessMessage(message, viewController: self)
    }
    func displayErrorMessage(message: String) {
        self.showErrorMessage(message, viewController: self)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView:TeamHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath) as! TeamHeaderCollectionReusableView
            
            headerView.sectionTitleLabel.text = self.team.name
            
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.players.count
    }
    
    // make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell:PlayerCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PlayerCollectionViewCell
        
        let player:TeamPlayersViewModel.DisplayedPlayer = self.players[indexPath.row]
        
        if let teamColor = self.team.highlightColor where !teamColor.isEmpty {
            cell.backgroundColor = UIColor.init(rgb: UInt(teamColor)!)
        }
        
        cell.avatarImage.imageFromUrl(link: player.imageURL!, placeholderImage: UIImage(named:"Default"))       
        cell.fullnameLabel.text = player.firstName + "\n" + player.lastName
        cell.jerseyNumberLabel.text = player.jerseyNumber
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)
        let widthForOneItem = widthAvailbleForAllItems / self.columnsNumber - flowLayout.minimumInteritemSpacing
        
        
        return CGSize(width: CGFloat(widthForOneItem), height: (flowLayout.itemSize.height))
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        var playerSelected:TeamPlayersViewModel.DisplayedPlayer = self.players[indexPath.row]
        playerSelected.teamID = self.team.teamID
        
        self.output.getResultForTeamPlayerSelected(playerSelected)
    }
    
    
    // MARK: privates
    func showMessage(message: String, withTitle title: String, hasCancelButton: Bool = false, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        if hasCancelButton {
            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        }
        
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(message: String, viewController: UIViewController) {
        self.showMessage(message, withTitle: "ERROR", hasCancelButton: false, viewController: viewController)
    }
    
    func showSuccessMessage(message: String, viewController: UIViewController) {
        self.showMessage(message, withTitle: "SUCCESS", hasCancelButton: false, viewController: viewController)
    }

}

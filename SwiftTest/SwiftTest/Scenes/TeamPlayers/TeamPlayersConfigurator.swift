//
//  TeamPlayersConfigurator.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright (c) 2016 Sports Illustrated. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension TeamPlayersViewController: TeamPlayersPresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension TeamPlayersInteractor: TeamPlayersViewControllerOutput {}

extension TeamPlayersPresenter: TeamPlayersInteractorOutput {}

class TeamPlayersConfigurator {

    // MARK: Object lifecycle

    static var sharedInstance = TeamPlayersConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: TeamPlayersViewController) {
        let router = TeamPlayersRouter()
        router.viewController = viewController

        let presenter = TeamPlayersPresenter()
        presenter.output = viewController

        let interactor = TeamPlayersInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}

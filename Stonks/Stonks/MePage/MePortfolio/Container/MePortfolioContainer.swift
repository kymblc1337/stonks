//
//  MePortfolioContainer.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 12.10.2020.
//

import UIKit

class MePortfolioContainer {
    let viewController: MePortfolioViewController
    private(set) weak var router: MePortfolioRouter?

    class func assemble(with context: MePortfolioContext) -> MePortfolioContainer {
        let storyboard = UIStoryboard(name: Storyboard.mePage.name, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Storyboard.mePage.name) as? MePortfolioViewController else {
            fatalError("MePorfolioContainer: viewController must be type MePortfolioViewController")
        }

        let presenter = MePortfolioPresenter()
        let router = MePortfolioRouter()

        vc.presenter = presenter
        presenter.view = vc
        router.viewController = vc
        return MePortfolioContainer(view: vc, router: router)
    }

    private init(view: MePortfolioViewController, router: MePortfolioRouter) {
        self.viewController = view
        self.router = router
    }
}

struct MePortfolioContext {

}
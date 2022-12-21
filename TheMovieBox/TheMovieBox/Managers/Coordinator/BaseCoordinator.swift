//
//  BaseCoordinator.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit
import SafariServices

class BaseCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    func eventOccured(with type: CoordinatorEvent) { }
    
    func start() {
        var vc: UIViewController & Coordinating = DashboardVC.instantiate(from: .dashboard)
        vc.coordinator = DashboardCoordinator(navigationController: self.navigationController)
        navigationController?.navigationBar.isHidden = true
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    func present(_ vc: UIViewController) {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isHidden = true
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func dismiss(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func push(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

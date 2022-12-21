//
//  Coordinator.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

enum StoryboardType: String {
    case dashboard = "Dashboard"
    case movie = "Movie"
    case auth = "Authentication"
    
    func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

protocol Storyboarded {
    static func instantiate(from storyboard: StoryboardType) -> Self
}

enum CoordinatorEvent {
    case buttonTapped
}

protocol Coordinator {
    func present(_ vc: UIViewController)
    func start()
}

protocol Coordinating {
    var coordinator: BaseCoordinator? { get set }
}


extension Storyboarded where Self: UIViewController {
    static func instantiate(from storyboard: StoryboardType) -> Self {
        let className = NSStringFromClass(self).components(separatedBy: ".")[1]
        return storyboard.instance.instantiateViewController(withIdentifier: className) as? Self ?? Self()
    }
}

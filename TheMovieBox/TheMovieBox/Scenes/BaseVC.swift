//
//  BaseVC.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

class BaseVC: UIViewController, Coordinating, Storyboarded {
    var coordinator: BaseCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

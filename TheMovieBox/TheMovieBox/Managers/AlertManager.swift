//
//  AlertManager.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//
import UIKit

class AlertManager {
    
    func showAlert(title: String = TextConstants.errorTitle, message: String = TextConstants.errorMessage, alertAction: (() -> Void)?, viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: TextConstants.ok, style: .default) { (action) in
            alertAction?()
        }
        alertController.addAction(action)
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}

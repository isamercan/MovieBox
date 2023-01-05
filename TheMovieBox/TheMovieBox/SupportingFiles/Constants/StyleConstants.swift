//
//  StyleConstants.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

struct StyleConstants {
    
    struct TabBar {
        static let barTintColor = UIColor.white
        static let tintColor = StyleConstants.Color.darkBlue
        static let unselectedItemTintColor = StyleConstants.Color.lightBlue
                
        enum TabBarTitle: String {
            case home = "Home"
            case genres = "Genres"
            case search = "Search"
            case favorite = "Favorite"
        }
        
        enum TabBarImage: String {
            case home = "house"
            case genres = "tray.full"
            case search = "magnifyingglass"
            case favorite = "heart.fill"
        }
        
    }
    
    struct Color {
        static let darkYellow = UIColor(hex: "#FFD130")
        static let lightGreen = UIColor(hex: "#F1FAEE")
        static let lightBlue = UIColor(hex: "#A8DADC")
        static let pastelBlue = UIColor(hex: "#457B9D")
        static let darkBlue = UIColor(hex: "#202123")

        
    }
        
    struct Font {
        static let largeTitle = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        static let title1 = UIFont(name: "HelveticaNeue-Medium", size: 19.0)
        static let title2 = UIFont(name: "HelveticaNeue-Medium", size: 17.0)
        static let title3 = UIFont(name: "HelveticaNeue-Medium", size: 15.5)
        static let headline = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
        static let body = UIFont(name: "HelveticaNeue", size: 14.0)
        static let callout = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        static let subhead = UIFont(name: "HelveticaNeue-Medium", size: 12.5)
        static let footnote = UIFont(name: "HelveticaNeue-Medium", size: 11.5)
        static let caption1 = UIFont(name: "HelveticaNeue-Medium", size: 11.0)
        static let caption2 = UIFont(name: "HelveticaNeue-Medium", size: 10.0)
        
    }
    struct Size {
        static let xSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    struct Image {
        static let heart = UIImage(systemName: "heart")
        static let heartFill = UIImage(systemName: "heart.fill")
    }
    
}

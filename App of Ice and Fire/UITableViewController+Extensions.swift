//
//  UITableViewController+Extensions.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/19/21.
//

import Foundation
import UIKit

extension UITableViewController {
    
    func applyImageBackgroundToTheNavigationBar() {
        
        guard let bounds = navigationController?.navigationBar.bounds else { return }
        
        var backImageForDefaultBarMetrics =
            UIImage.gradientImage(bounds: bounds,
                                  colors: [UIColor.init(named: "Background")!.cgColor, UIColor.systemFill.cgColor])
        var backImageForLandscapePhoneBarMetrics =
            UIImage.gradientImage(bounds: bounds,
                                  colors: [UIColor.init(named: "Background")!.cgColor, UIColor.systemFill.cgColor])
        
        backImageForDefaultBarMetrics =
            backImageForDefaultBarMetrics.resizableImage(
                withCapInsets: UIEdgeInsets(top: 0,
                                            left: 0,
                                            bottom: backImageForDefaultBarMetrics.size.height - 1,
                                            right: backImageForDefaultBarMetrics.size.width - 1))
        backImageForLandscapePhoneBarMetrics =
            backImageForLandscapePhoneBarMetrics.resizableImage(
                withCapInsets: UIEdgeInsets(top: 0,
                                            left: 0,
                                            bottom: backImageForLandscapePhoneBarMetrics.size.height - 1,
                                            right: backImageForLandscapePhoneBarMetrics.size.width - 1))
        
        let navBar = self.navigationController!.navigationBar
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundImage = backImageForDefaultBarMetrics
        
        let compactAppearance = standardAppearance.copy()
        compactAppearance.backgroundImage = backImageForLandscapePhoneBarMetrics
        
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navBar.compactAppearance = compactAppearance
    }
}

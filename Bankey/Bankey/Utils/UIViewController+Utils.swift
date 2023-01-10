//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Jose Sousa on 09/01/2023.
//

import UIKit

extension UIViewController {
    
    // 'statusBarFrame' was deprecated in iOS 13.0
//    func setStatusBar() {
//         let statusBarSize =  UIApplication.shared.statusBarFrame.size
//
//        let frame = CGRect(origin: .zero, size: statusBarSize)
//        let statusbarView = UIView(frame: frame)
//
//        statusbarView.backgroundColor = appColor
//        view.addSubview(statusbarView)
//    }
    
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

//
//  File.swift
//  SwiftRadio
//
//  Created by jge on 2020/08/21.
//  Copyright © 2020 matthewfecher.com. All rights reserved.
//

import Foundation
import SwiftUI

struct CCMVCtoUI: UIViewControllerRepresentable {

    typealias UIViewControllerType = StationsViewController

    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "MainView")
        return controller as! StationsViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

//    typealias UIViewControllerType = UINavigationController
//
//    func makeUIViewController(context: Context) -> UINavigationController {
//        let viewController = StationsVC()
//        let navigationController = UINavigationController(rootViewController: viewController)
//        return navigationController
//    }
//
//    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
//
//

}

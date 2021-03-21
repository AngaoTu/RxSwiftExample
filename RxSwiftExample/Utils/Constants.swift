//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by tuqiangyao on 2021/1/8.
//

import UIKit

struct Constants {
    struct Size {
        static let screenSize: CGSize = UIScreen.main.bounds.size
        static let screenWidth: CGFloat = Size.screenSize.width
        static let screenHeight: CGFloat = Size.screenSize.height
        static let statsuBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        static let statusBarAndNavigationBarHeight:CGFloat = statsuBarHeight + 44
    }
}

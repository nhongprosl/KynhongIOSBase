//
//  PageViewController.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation

typealias PageViewControllerInitialData = (initialIndex: Int, initialData: Any?)
class PageViewController: ViewController {
    var currentSelected: Int = 0
    var viewControllers: [ViewController] = []
}

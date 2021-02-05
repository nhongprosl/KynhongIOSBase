//
//  SceneManager.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/27/21.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
protocol ApplicationLifeCycleListener: class {
    func applicationDidBecomeActive()
}
class SceneManager {
    public static let shared = SceneManager()
    let disposeBag = DisposeBag()
    weak var applicationListener: ApplicationLifeCycleListener?
    
    fileprivate var window: UIWindow!
    fileprivate var didResignActive: Bool = false
    fileprivate var visualEffectView: UIVisualEffectView!
    fileprivate var rootSceneName: String = Scene.initView.rawValue
    fileprivate var timeHideApp: TimeInterval = 0
    
    private init() {
    }
    
    func config(_ window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
        self.start(scene: .initView)
    }
    
    func start(scene: Scene, initialData: Any? = nil) {
        let viewController = scene.getViewController(initialData)
        switch scene.showType {
        case .root:
            let navi = self.makeNavigation(viewController)
            self.window.rootViewController = navi
            self.rootSceneName = scene.rawValue
        case .present:
            let navi = self.makeNavigation(viewController)
            navi.modalPresentationStyle = .fullScreen
            self.getCurrentNavigation(window.rootViewController)?.show(navi, sender: nil)
        case .push:
            self.getCurrentNavigation(window.rootViewController)?.show(viewController, sender: nil)
        case .embedded(let index, let parent):
            self.start(scene: scene, in: parent, at: index, initialData: initialData)
        }
    }
    
    func back(from scene: Scene, completion: (()->Void)? = nil) {
        switch scene.showType {
        case .push:
            self.getCurrentNavigation(window.rootViewController)?.popViewController(animated: true)
            completion?()
        case .present:
            if let navi = self.getCurrentNavigation(window.rootViewController), navi.presentingViewController != nil {
                navi.dismiss(animated: true, completion: completion)
            }
        default:
            break
        }
    }
    
    func back(beforeOf scene: Scene, completion: @escaping (_ success: Bool)->Void) {
        let viewController = scene.getViewController()
        if self.getViewController(in: self.window.rootViewController, with: viewController) != nil {
            self.popViewController(in: self.window.rootViewController, with: viewController) {
                self.getCurrentNavigation(self.window.rootViewController)?.popViewController(animated: true)
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    fileprivate func start(scene: Scene, in parent: Scene, at index: Int, initialData: Any?) {
        switch parent.showType {
        case .root:
            if self.rootSceneName == parent.rawValue {
                self.dissmissAll(window.rootViewController) {[weak self] in
                    guard let self = self else {return}
                    if let navi = self.window.rootViewController as? UINavigationController, let pageVC = navi.viewControllers.first as? PageViewController {
                        pageVC.currentSelected = index
                    }
                }
            } else {
                let initialData: PageViewControllerInitialData = (index, initialData)
                self.start(scene: parent, initialData: initialData)
            }
        case .push:
            let initialData: PageViewControllerInitialData = (index, initialData)
            self.start(scene: parent, initialData: initialData)
        case .present:
            let initialData: PageViewControllerInitialData = (index, initialData)
            self.start(scene: parent, initialData: initialData)
        case .embedded(let index, let parentOfParent):
            self.start(scene: parent, in: parentOfParent, at: index, initialData: initialData)
        }
    }
    
    fileprivate func dissmissAll(_ viewController: UIViewController?, completion: @escaping ()->Void) {
        if let presentedVC = viewController?.presentedViewController {
            self.dissmissAll(presentedVC, completion: completion)
        } else if let presentingVC = viewController?.presentingViewController {
            viewController?.dismiss(animated: true, completion: {
                self.dissmissAll(presentingVC, completion: completion)
            })
        } else {
            completion()
        }
    }
    
    fileprivate func getCurrentNavigation(_ viewController: UIViewController?) -> UINavigationController? {
        if let vc = viewController {
            if let presentedVC = vc.presentedViewController {
                return self.getCurrentNavigation(presentedVC)
            } else if let navi = vc as? UINavigationController {
                return navi
            }
        }
        return nil
    }
    
    fileprivate func makeNavigation(_ viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
    
    fileprivate func getViewController(in rootViewController: UIViewController?, with viewController: UIViewController) -> UIViewController? {
        if let rootVC = rootViewController {
            if type(of: rootVC) == type(of: viewController) {
                return rootVC
            } else if let navVC = rootVC as? UINavigationController {
                for vc in navVC.viewControllers {
                    if type(of: vc) == type(of: viewController) {
                        return vc
                    } else if let pageVC = vc as? PageViewController {
                        for childVC in pageVC.viewControllers {
                            if type(of: childVC) == type(of: viewController) {
                                return pageVC
                            }
                        }
                    }
                }
            } else if let pageVC = rootVC as? PageViewController {
                for childVC in pageVC.viewControllers {
                    if type(of: childVC) == type(of: viewController) {
                        return pageVC
                    }
                }
            } else if let presentedVC = rootVC.presentedViewController {
                return self.getViewController(in: presentedVC, with: viewController)
            }
        } else {
            let rootVC = self.window.rootViewController
            return self.getViewController(in: rootVC, with: viewController)
        }
        return nil
    }
    
    fileprivate func popViewController(in rootViewController: UIViewController?, with viewController: UIViewController, completion: @escaping ()->Void) {
        if let rootVC = rootViewController {
            if type(of: rootVC) == type(of: viewController) {
                completion()
            } else if let presentedVC = rootVC.presentedViewController {
                self.popViewController(in: presentedVC, with: viewController, completion: completion)
            } else if let navVC = rootVC as? UINavigationController {
                for vc in navVC.viewControllers {
                    if type(of: vc) == type(of: viewController) {
                        navVC.popToViewController(vc, animated: true)
                        completion()
                        return
                    } else if let pageVC = vc as? PageViewController {
                        for i in 0..<pageVC.viewControllers.count {
                            let childVC = pageVC.viewControllers[i]
                            if type(of: childVC) == type(of: viewController) {
                                pageVC.currentSelected = i
                                navVC.popToViewController(pageVC, animated: true)
                                completion()
                                return
                            }
                        }
                    }
                }
            } else if let pageVC = rootVC as? PageViewController {
                for i in 0..<pageVC.viewControllers.count {
                    let childVC = pageVC.viewControllers[i]
                    if type(of: childVC) == type(of: viewController) {
                        pageVC.currentSelected = i
                        completion()
                        return
                    }
                }
            } else if let presentingVC = rootVC.presentingViewController {
                rootVC.dismiss(animated: true) {
                    self.popViewController(in: presentingVC, with: viewController, completion: completion)
                }
            }
        } else {
            let rootVC = self.window.rootViewController
            self.popViewController(in: rootVC, with: viewController, completion: completion)
        }
    }
    
    // action
    func appDidBecomeActive() {
        
    }
    
    func appWillResignActive() {
        
    }
    
    func appDidEnterBackground() {
        
    }
    
    func appWillEnterForeground() {
        
    }
    
}

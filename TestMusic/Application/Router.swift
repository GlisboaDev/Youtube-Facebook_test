//
//  Router.swift
//
//  Created by Guilherme Silva Lisboa on 2016-08-10.
//  Copyright © 2016 LDevelopment. All rights reserved.
//

import UIKit

enum NavigationPath: Int {
    case login, main, none
}

class Router {
    
    // MARK: - Properties
    
    var childRouter: Router? // Has to be optional since the router might not have children.
    weak var parent: Router? // Has to be optional since the base router wont have a parent.
    var controller: UIViewController = UIViewController()
    
    var possiblePaths: [NavigationPath] {
        return []
    }
    var routerPath: NavigationPath {
        return .none
    }
    
    init(parent: Router) {
        self.parent = parent
        parent.childRouter = self
    }
    
    // MARK: - Lifecycle
    
    /**
     Root router initializer. Should only be used for the root router.
     */
    init() {
    }
    
    // MARK: - Router Methods
    
    /**
     Navigate to new destination from current controller
     - parameter destination: Navigation destination
     - parameter data:        optional data to be transmitted between routers.
     - returns: if the path is possible or not.
     */
    @discardableResult final func navigateTo(destination: NavigationPath, data: Any? = nil) -> Bool {
        
        guard routerPath != destination else {
            guard let childRouter = self.childRouter else { return false }
            childRouter.dismissController(router: self, data: data)
            return true
        }
        // check if it's to be intercepted, otherwise take the default destination router
        let destinationRouter: Router? = destinationRouterForPath(path: destination, data: data)
        guard let router = destinationRouter else {
            guard let parent = self.parent else { return false }
            return parent.navigateTo(destination: destination, data: data)
        }
        displayRouter(router: router, path: destination)
        childRouter = router
        return true
    }
    
    // TODO: Check this too. probably dismissController isn't needed. Check to remove.
    /**
     Dismiss this router from the navigation
     - parameter destination: new destination to be handled by the parent if necessary
     */
    private func dismissController(router: Router, data: Any? = nil) {
        parent?.childWillReturnNavigation(data: data)
        guard let navigationController = router.controller.navigationController else {
            self.controller.dismiss(animated: true, completion: nil)
            return
        }
        if let navController = router.controller as? UINavigationController {
            navController.popToRootViewController(animated: true)
        } else {
            navigationController.popToViewController(router.controller, animated: true)
        }
    }
    
    // MARK: Abstract Methods
    
    /**
     Called when the router navigate back the flow to its parent.
     - parameter data: any data that might be passed to the previous router in the flow.
     */
    func childWillReturnNavigation(data: Any? = nil) {
        // To be overrited.
    }
    
    /**
     router to be displayed for this path
     - parameter path: navigation path
     - parameter data: optional data to be transmitted between routers.
     - returns: router to be displayed.
     */
    func destinationRouterForPath(path: NavigationPath, data: Any?) -> Router? {
        return nil
    }
    
    /**
     Display a router in a specific way based on the navigation
     - parameter router: router to be displayed
     - parameter path:   navigation path.
     */
    func displayRouter(router: Router, path: NavigationPath) {
        if let navigationController = controller.navigationController {
            navigationController.pushViewController(router.controller, animated: true)
        } else {
            controller.present(router.controller, animated: true, completion: nil)
        }
    }
}

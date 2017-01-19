//
//  IntroViewController.swift
//  LazyTransitionsExample
//
//  Created by Serghei Catraniuc on 1/10/17.
//  Copyright © 2017 BeardWare. All rights reserved.
//

import UIKit
import LazyTransitions

class IntroViewController: UIViewController {
    fileprivate var transitioner = UniversalTransitionsHandler()
    
    @IBAction func dismissDemoTapped() {
        let catVC = CatViewController.instantiate(withTitle: "Dismiss Demo")
        let navController = UINavigationController(rootViewController: catVC)
        present(navController, animated: true, completion: nil)
        transitioner = UniversalTransitionsHandler()
        transitioner.addTransition(for: catVC.collectionView!)
        let view = catVC.view as UIView
        transitioner.addTransition(for: view)
        transitioner.triggerTransitionAction = { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        catVC.didScrollCallback = { [weak self] scrollView in
            self?.transitioner.didScroll(scrollView)
        }
        navController.transitioningDelegate = transitioner
    }
    
    @IBAction func popDemoTapped() {
        let catVC = CatViewController.instantiate(withTitle: "Pop Demo")
        catVC.removeDismissButton()
        navigationController?.pushViewController(catVC, animated: true)
        transitioner = UniversalTransitionsHandler(animator: PopAnimator(orientation: .leftToRight))
        transitioner.addTransition(for: catVC.view)
        transitioner.triggerTransitionAction = { [weak self] _ in
            _ = self?.navigationController?.popViewController(animated: true)
        }
        transitioner.allowedOrientations = [.leftToRight]
        navigationController?.delegate = transitioner
    }
}

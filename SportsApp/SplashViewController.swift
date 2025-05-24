//
//  SplashViewController.swift
//  SportsApp
//
//  Created by mac on 24/05/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSplashAnimation()
    }
    
    private func playSplashAnimation() {
        animationView = .init(name: "Animation - 1748084695319")
      //  animationView!.frame = view.bounds
        let size: CGFloat = 300
        let centerX = (view.bounds.width - size) / 2
        let centerY = (view.bounds.height - size) / 2
        animationView!.frame = CGRect(x: centerX, y: centerY, width: size, height: size)

        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        view.addSubview(animationView!)
        animationView!.play { [weak self] _ in
            self?.navigateToMainApp()
        }
    }
    
    private func navigateToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let navController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? UINavigationController {
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
}

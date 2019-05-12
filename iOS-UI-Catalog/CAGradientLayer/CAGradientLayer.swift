//
//  CAGradientLayer.swift
//  iOS-UI-Catalog
//
//  Created by オムラユウキ on 2019/05/11.
//  Copyright © 2019 Swifter. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    @IBOutlet var slideView: AnimatedMaskLabel!
    @IBOutlet var time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipe = UISwipeGestureRecognizer(target: self,  action: #selector(ViewController4.didSlide))
        swipe.direction = .right
        slideView.addGestureRecognizer(swipe)
    }
    
    @objc func didSlide() {
        
        // reveal the meme upon successful slide
        let image = UIImageView(image: UIImage(named: "meme"))
        image.center = view.center
        image.center.x += view.bounds.size.width
        view.addSubview(image)
        
        UIView.animate(withDuration: 0.33, delay: 0.0,
                       animations: {
                        self.time.center.y -= 200.0
                        self.slideView.center.y += 200.0
                        image.center.x -= self.view.bounds.size.width
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.33, delay: 1.0,
                       animations: {
                        self.time.center.y += 200.0
                        self.slideView.center.y -= 200.0
                        image.center.x += self.view.bounds.size.width
        },
                       completion: {_ in
                        image.removeFromSuperview()
        }
        )
    }
    
}

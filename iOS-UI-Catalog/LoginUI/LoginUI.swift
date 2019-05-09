import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class LoginUI: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        [username, password].forEach {
            $0?.center.x -= view.frame.width
        }
        
        [cloud1, cloud2, cloud3, cloud4].forEach {
            $0.center.x -= view.bounds.width
        }
        loginButton.center.y += 30
        loginButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        statusPosition = status.center
        
        UIView.animate(withDuration: 2, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.cloud1.center.x += self.view.bounds.width
        })
        
        UIView.animate(withDuration: 2, delay: 1, options: [.repeat, .autoreverse], animations: {
            self.cloud2.center.x += self.view.bounds.width
        })
        
        UIView.animate(withDuration: 2, delay: 1.5, options: [.repeat, .autoreverse], animations: {
            self.cloud3.center.x += self.view.bounds.width
        })
        
        UIView.animate(withDuration: 2, delay: 2, options: [.repeat, .autoreverse], animations: {
            self.cloud4.center.x += self.view.bounds.width
        })
        
        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            self.username.center.x += self.view.frame.width
            self.password.center.x += self.view.frame.width
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.center.y -= 30
            self.loginButton.alpha = 1
        })
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.bounds.size.width += 80
        })
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.center.y += 60
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1)
        }, completion: { _ in
            self.showMessage(index: 0)
        })
    }
    
    func showMessage(index: Int) {
        label.text = messages[index]
        
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
        }) { _ in
            delay(0.5, completion: {
                if index < self.messages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    UIView.transition(from: self.status, to: self.loginButton, duration: 0.7, options: [.curveEaseOut, .transitionCurlUp], completion: { _ in
                        self.loginButton.center.y -= 60
                    })
                }
            })
        }
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0, options: [], animations: {
            self.status.center.x += self.view.frame.width
        }) { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index: index + 1)
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    
}

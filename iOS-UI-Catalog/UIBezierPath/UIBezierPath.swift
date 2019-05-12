import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet var myAvatar: AvatarView!
    @IBOutlet var opponentAvatar: AvatarView!
    
    @IBOutlet var status: UILabel!
    @IBOutlet var vs: UILabel!
    @IBOutlet var searchAgain: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchForOpponent()
    }
    
    func searchForOpponent() {
        let avatarSize = myAvatar.frame.size
        let bounceXOffset: CGFloat = avatarSize.width/1.9
        let morphSize = CGSize(
            width: avatarSize.width * 0.85,
            height: avatarSize.height * 1.1)
        
        let rightBouncePoint = CGPoint(
            x: view.frame.size.width/2.0 + bounceXOffset,
            y: myAvatar.center.y)
        
        let leftBouncePoint = CGPoint(
            x: view.frame.size.width/2.0 - bounceXOffset,
            y: myAvatar.center.y)
        
        myAvatar.bounceOff(point: rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOff(point: leftBouncePoint, morphSize: morphSize)
        
        
    }
    
    @IBAction func actionSearchAgain() {
        UIApplication.shared.keyWindow!.rootViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as UIViewController
    }
}

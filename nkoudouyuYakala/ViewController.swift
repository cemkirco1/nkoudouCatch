//
//  ViewController.swift
//  nkoudouyuYakala
//
//  Created by cem on 21.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var area1: UIImageView!
    @IBOutlet weak var area2: UIImageView!
    @IBOutlet weak var area3: UIImageView!
    @IBOutlet weak var area4: UIImageView!
    @IBOutlet weak var area5: UIImageView!
    @IBOutlet weak var area6: UIImageView!
    @IBOutlet weak var area7: UIImageView!
    @IBOutlet weak var area8: UIImageView!
    @IBOutlet weak var area9: UIImageView!
    
    
    var time=Timer()
    var counter = 10
    var score = 0
    var hideTime = Timer()
    var nkoudouArray = [UIImageView]()
    var highScore = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storegHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storegHighscore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: 0"
        }
        
        if let newScore = storegHighscore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        area1.isUserInteractionEnabled = true
        area2.isUserInteractionEnabled = true
        area3.isUserInteractionEnabled = true
        area4.isUserInteractionEnabled = true
        area5.isUserInteractionEnabled = true
        area6.isUserInteractionEnabled = true
        area7.isUserInteractionEnabled = true
        area8.isUserInteractionEnabled = true
        area9.isUserInteractionEnabled = true
        
        let resture1 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture2 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture3 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture4 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture5 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture6 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture7 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture8 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        let resture9 = UITapGestureRecognizer(target: self, action: #selector(picturesScore))
        
        area1.addGestureRecognizer(resture1)
        area2.addGestureRecognizer(resture2)
        area3.addGestureRecognizer(resture3)
        area4.addGestureRecognizer(resture4)
        area5.addGestureRecognizer(resture5)
        area6.addGestureRecognizer(resture6)
        area7.addGestureRecognizer(resture7)
        area8.addGestureRecognizer(resture8)
        area9.addGestureRecognizer(resture9)
        
        
        timeLabel.text = String(counter)
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timePrime), userInfo: nil, repeats: true)
        
        hideTime = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePic), userInfo: nil, repeats: true)
        nkoudouArray = [area1,area2,area3,area4,area5,area6,area7,area8,area9]
        
        
    }
    @objc func hidePic(){
        for myArray in nkoudouArray{
            myArray.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(nkoudouArray.count-1)))
        nkoudouArray[random].isHidden = false
        
        
    }
    
    
    @objc func  picturesScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }

    @objc func timePrime(){
        counter -= 1
        timeLabel.text=String(counter)
        
        if counter == 0 {
            time.invalidate()
            hideTime.invalidate()
            
            if  self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Game Over", message: "Time's Up", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timePrime), userInfo: nil, repeats: true)
                self.hideTime = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidePic), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}


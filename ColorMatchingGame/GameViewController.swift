//
//  GameViewController.swift
//  ColorMatchingGame
//
//  Created by Toriq Wahid Syaefullah on 11/06/20.
//  Copyright © 2020 Toriq Wahid Syaefullah. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var qSwitch: UISwitch!
    var arrCellData = [cellData(color: UIColor.cyan, text: "Cyan"),
                       cellData(color: UIColor.green,  text: "Green"),
                       cellData(color: UIColor.gray,  text: "Gray"),
                       cellData(color: UIColor.magenta,  text: "Magenta"),
                       cellData(color: UIColor.red, text: "Red"),
                       cellData(color: UIColor.black,  text: "Black"),
                       cellData(color: UIColor.blue,  text: "Blue"),
                       cellData(color: UIColor.brown,  text: "Brown"),
                       cellData(color: UIColor.orange, text: "Orange"),
                       cellData(color: UIColor.purple,  text: "Purple"),
                       cellData(color: UIColor.white,  text: "White"),
                       cellData(color: UIColor.yellow,  text: "Yellow")]
    

    var indexColor: Int!
    var indexText: Int!
    var score = 0
    var countdown = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        arrCellData.shuffle()
        collectionView.register(UINib.init(nibName: "ColorCVCell", bundle: nil), forCellWithReuseIdentifier: "celll")
        
        randomSwitch()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }

    @objc func update() {
        if(countdown > 0) {
            countdown -= 1
            timeLabel.text = String(countdown)
        }
        
        if(countdown < 10){
            startTick()
        }
        
        if(countdown == 0){
            stopTick()
            showAlert()
        }
    }
    func randomSwitch(){
        let i = Int.random(in: 0 ... 1)
        i == 0 ? qSwitch.setOn(true, animated: true) : qSwitch.setOn(false, animated: true)
        randomColor()
    }
    
    func randomColor(){
        scoreLabel.text = String(score)
    
        indexText = Int.random(in: 0 ... arrCellData.count - 1)
        colorLabel.text = arrCellData[indexText].text
        qSwitch.onTintColor = arrCellData[indexText].color
        
        indexColor = Int.random(in: 0 ... arrCellData.count - 1)
        colorLabel.textColor = arrCellData[indexColor].color
        qSwitch.tintColor = arrCellData[indexColor].color
        qSwitch.layer.cornerRadius = qSwitch.frame.height / 2
        qSwitch.backgroundColor = arrCellData[indexColor].color
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Game Over", message: "Your Score: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start Again ", style: .cancel, handler: { (_) in
            self.viewDidLoad()
            self.viewWillAppear(true)
        }))
        alert.addAction(UIAlertAction(title: "Next Game", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "to_game1", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width)/6
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celll", for: indexPath ) as! ColorCVCell
        
        cell.configure(with: arrCellData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if qSwitch.isOn {
            if indexText == indexPath.row {
                print("match 1")
                playSound(soundName: "correct")
                score += 1
                randomSwitch()
            }else{
                playSound(soundName: "wrong")
                print("not match")
            }
        } else {
            if indexColor == indexPath.row {
                print("match 2")
                playSound(soundName: "correct")
                score += 1
                randomSwitch()
            }else{
                playSound(soundName: "wrong")
                print("not match")
            }
        }
        
    }
}

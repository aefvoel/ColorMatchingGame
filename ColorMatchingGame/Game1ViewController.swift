//
//  Game1ViewController.swift
//  ColorMatchingGame
//
//  Created by Toriq Wahid Syaefullah on 15/06/20.
//  Copyright © 2020 Toriq Wahid Syaefullah. All rights reserved.
//

import UIKit

class Game1ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var arrCellData = [cellData(color: UIColor.green,  text: "Green"),
                       cellData(color: UIColor.gray,  text: "Gray"),
                       cellData(color: UIColor.red, text: "Red"),
                       cellData(color: UIColor.black,  text: "Black"),
                       cellData(color: UIColor.blue,  text: "Blue"),
                       cellData(color: UIColor.orange, text: "Orange"),
                       cellData(color: UIColor.purple,  text: "Purple"),
                       cellData(color: UIColor.yellow,  text: "Yellow"),
                       cellData(color: UIColor.green,  text: "Green"),
                       cellData(color: UIColor.gray,  text: "Gray"),
                       cellData(color: UIColor.red, text: "Red"),
                       cellData(color: UIColor.black,  text: "Black"),
                       cellData(color: UIColor.blue,  text: "Blue"),
                       cellData(color: UIColor.orange, text: "Orange"),
                       cellData(color: UIColor.purple,  text: "Purple"),
                       cellData(color: UIColor.yellow,  text: "Yellow")]
    

    var indexColor: Int!
    var indexText: Int!
    var score = 0
    var countdown = 60
    
    var firstPick = ""
    var secondPick = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        arrCellData.shuffle()
        collectionView.register(UINib.init(nibName: "ColorCVCell", bundle: nil), forCellWithReuseIdentifier: "celll")
        
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
    func showAlert() {
        let alert = UIAlertController(title: "Game Over", message: "Your Score: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start Again ", style: .cancel, handler: { (_) in
            self.viewDidLoad()
            self.viewWillAppear(true)
        }))
        alert.addAction(UIAlertAction(title: "Main Menu", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "to_menu", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Game1ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        if firstPick == "" {
            firstPick = arrCellData[indexPath.row].text
            indexText = indexPath.row
            print("1st pick")
        } else {
            secondPick = arrCellData[indexPath.row].text
            print("2nd pick")
            if firstPick == secondPick {
                arrCellData.remove(at: indexText)
                arrCellData.remove(at: indexPath.row)
                
                firstPick = ""
                secondPick = ""
                score += 1
                scoreLabel.text = String(score)
                print("match")
                playSound(soundName: "correct")
                collectionView.reloadData()
            }
            else {
                firstPick = ""
                secondPick = ""
                print("not match")
                playSound(soundName: "wrong")
                collectionView.reloadData()
            }
        }
    }
}

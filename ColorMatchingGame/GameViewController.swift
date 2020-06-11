//
//  GameViewController.swift
//  ColorMatchingGame
//
//  Created by Toriq Wahid Syaefullah on 11/06/20.
//  Copyright © 2020 Toriq Wahid Syaefullah. All rights reserved.
//

import UIKit

struct cellData {
    let color : UIColor!
    let text : String!
    
}
class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var qSwitch: UISwitch!
    var arrCellData = [cellData]()
    var indexColor: Int!
    var indexText: Int!
    
    var score = 0
    var countdown = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        arrCellData = [cellData(color: UIColor.cyan, text: "Cyan"),
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
        
        randomColor()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    @objc func update() {
        if(countdown > 0) {
            countdown -= 1
            timeLabel.text = String(countdown)
        }
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

}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath ) as! ColorCVCell
        
        cell.contentView.backgroundColor = arrCellData[indexPath.row].color
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if qSwitch.isOn {
            if indexText == indexPath.row {
                print("match")
                score += 1
                randomColor()
            }else{
                print("not match")
            }
        } else {
            if indexColor == indexPath.row {
                print("match")
                score += 1
                randomColor()
            }else{
                print("not match")
            }
        }
        
//        colorLabel.textColor = arrCellData[indexPath.row].color
//        colorLabel.text = arrCellData[indexPath.row].text
        
    }
}

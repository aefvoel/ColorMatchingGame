//
//  sound.swift
//  ColorMatchingGame
//
//  Created by Michael Sanjaya on 15/06/20.
//  Copyright © 2020 Toriq Wahid Syaefullah. All rights reserved.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?
var player2: AVAudioPlayer?

func playSound(soundName: String ) {
    print("Trying sound")
    guard let path = Bundle.main.path(forResource: soundName, ofType:"mp3") else {
        print ("File not found")
        return }
    let url = URL(fileURLWithPath: path)
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = player else { return }

        player.play()

        print("playing \(soundName)")
    } catch let error {
        print(error.localizedDescription)
    }
}

func startTick() {
    print("tick")
    guard let path = Bundle.main.path(forResource: "fastclock", ofType:"mp3") else {
        print ("File not found")
        return }
    let url = URL(fileURLWithPath: path)
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player2 = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player2 = player2 else { return }

        player2.play()

        print("tick")
    } catch let error {
        print(error.localizedDescription)
    }
}

func stopTick() {
    player2?.stop()
}

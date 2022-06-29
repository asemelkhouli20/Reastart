//
//  AudioPlayer.swift
//  Reastart
//
//  Created by Asem on 16/06/2022.
//

import Foundation
import AVFoundation

class AudioPlayer{
    static var audioPlayer:AVAudioPlayer?
    static func playSound (sound:String,type:String){
        if let path = Bundle.main.path(forResource: sound, ofType: type){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            }catch{
                
            }
        }
    }
}

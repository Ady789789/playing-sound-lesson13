//
//  ContentView.swift
//  playing sound lesson13
//
//  Created by natural health on 1/31/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var photoName = ""
    
    @State private var lastMessageNumber = -1
    @State private var lastphotoNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    
    let numberOfImage = 10
    
    @State private var lastSoundNumber = -1
    let numberOfSounds = 6
    
    
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeIn(duration: 0.15), value: message)
            Spacer()
            Image(photoName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 45))
                .shadow(radius: 50)
                .animation(.default, value: photoName)
            
            Spacer()
            
            Button("Show Message!") {
                let messages = ["You are Awesome!",
                                "You are Great!",
                                "You are Fantastic!",
                                "Fabulous? That's You!",
                                "You  make me Smile!",
                                "When the Genius Bar needs help, they call You!"]
                
                
                var messageNumber = Int.random(in: 0...messages.count-1)
                while messageNumber == lastMessageNumber{
                    messageNumber = Int.random(in: 0...messages.count-1)
                }
                message = messages[messageNumber]
                lastMessageNumber = messageNumber
                
                
                var photoNumber: Int
                repeat {
                    photoNumber = Int.random(in: 0...numberOfImage-1)
                } while photoNumber == lastphotoNumber
                photoName = "photo\(photoNumber)"
                lastphotoNumber = photoNumber
                
                var soundNumber: Int
                repeat {
                    soundNumber = Int.random(in: 0...numberOfSounds-1)
                } while soundNumber == lastSoundNumber
                lastSoundNumber = soundNumber
                let soundName = "sound\(soundNumber)"
                
                guard let soundFile = NSDataAsset(name: soundName) else {
                    print("😭 Could not read file named \(soundName)")
                    return
                }
                do {
                    audioPlayer = try AVAudioPlayer(data: soundFile.data)
                    audioPlayer.play()
                } catch {
                    print("😭 ERROR: \(error.localizedDescription) creating audioPlayer.")
                    
                }
                
                
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        
        .padding()
    }
}


#Preview {
    ContentView()
}

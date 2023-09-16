//
//  MeditationView.swift
//  StoicMonk[Swift Migration]
//
//  Created by Jayanta Adhikary on 16/09/23.
//

import SwiftUI
import AVFoundation // Import AVFoundation framework

struct MeditationView: View {
    @State var showMenu: Bool = false
    @State var timer: Timer?
    @State var timeRemaining: TimeInterval = 600 // 10 minutes in seconds
    @State var isTimerRunning = false
    
    // Add audio-related properties
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isAudioPlaying = false
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    Text("Meditation Zone")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.043137254901960784, green: 0.29411764705882354, blue: 0.11372549019607843))
                    
                    Spacer()
                    
                    Button(action: {
                        if isTimerRunning {
                            // Reset the timer
                            timer?.invalidate()
                            timeRemaining = 600 // Reset to 10 minutes
                            isTimerRunning = false
                            
                            // Stop the audio
                            audioPlayer?.stop()
                            isAudioPlaying = false
                        } else {
                            // Start the timer
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                } else {
                                    timer?.invalidate()
                                    isTimerRunning = false
                                }
                            }
                            isTimerRunning = true
                            
                            // Start playing the audio
                            if let audioPlayer = audioPlayer {
                                audioPlayer.play()
                                isAudioPlaying = true
                            }
                        }
                    }) {
                        ZStack{
                            Circle()
                                .fill(Color(red: 0.06274509803921569, green: 0.42745098039215684, blue: 0.3764705882352941))
                                .frame(width: 250, height: 250)
                            VStack{
                                Text(timeString(timeRemaining))
                                    .font(.system(size: 30))
                                Text(isTimerRunning ? "Reset" : "Start")
                                    .font(.system(size: 15))
                                    .italic()
                            }
                            .foregroundColor(Color(red: 0.9529411764705882, green: 0.9607843137254902, blue: 0.984313725490196))
                        }
                    }
                    
                    Spacer()
                }
                
                GeometryReader { geometry in
                    SideMenuView()
                        .offset(x: showMenu ? 0 : -geometry.size.width)
                        .animation(.easeInOut(duration: 0.3))
                }
            }
            .background(
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showMenu.toggle()
                    } label: {
                        Image(systemName: "text.justify.left")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0.043137254901960784, green: 0.29411764705882354, blue: 0.11372549019607843))
                    }
                }
            }
        }
        .onAppear {
            if let audioUrl = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
                    audioPlayer?.prepareToPlay() // Ensure preparation
                } catch {
                    print("Error loading audio: \(error.localizedDescription)")
                }
            }

        }
        .onDisappear {
            // Stop the audio when the view disappears
            audioPlayer?.stop()
            isAudioPlaying = false
        }
    }
    
    // Function to format the time as "mm:ss"
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}



//struct MeditationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeditationView()
//    }
//}

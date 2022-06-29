//
//  HomeView.swift
//  Reastart
//
//  Created by Asem on 15/06/2022.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("OnBoarding") private var isOnBoarding = false
    let haptic = UINotificationFeedbackGenerator()
    @State private var isAnimation=false
    
    var body: some View {
        VStack{
          Spacer()
            ZStack{
                BackgroundImageView(Color: .gray.opacity(0.7))
                Image("character-2").resizable().scaledToFit()
                    .offset(y: isAnimation ? 25 : -25)
                    .animation(Animation.easeInOut(duration: 4).repeatForever(), value: isAnimation)
            }
            
            
                Text("The time that leads to mastery is dependent on the intensity of our foucs")
                .font(.title3).fontWeight(.light)
                .padding(.vertical,30).foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                Spacer()
            Button{
                withAnimation {
                    AudioPlayer.playSound(sound: "chimeup", type: "mp3")
                    isOnBoarding=true
                }
               
            } label: {Label("Restart", systemImage: "arrow.triangle.2.circlepath.circle.fill").font(.title3.bold())}
                .buttonStyle(.borderedProminent).buttonBorderShape(.capsule).controlSize(.large)

           
        }.padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    isAnimation=true
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

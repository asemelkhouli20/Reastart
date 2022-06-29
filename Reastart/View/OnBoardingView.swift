//
//  OnBoarding.swift
//  Reastart
//
//  Created by Asem on 15/06/2022.
//

import SwiftUI

struct OnBoardingView: View {
    
    @AppStorage("OnBoarding") private var isOnBoarding = true
    let haptic = UINotificationFeedbackGenerator()
    
    @State private var buttonWidth:Double = UIScreen.main.bounds.width-40
    @State private var buttonOffest:CGFloat=0.0
    
    @State private var imageOffest:CGFloat=0.0
    
    @State private var isAnimation=false
    var body: some View {
        ZStack {
            Color("LightBlue").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                TitleView(imageOffest: imageOffest)
                    .offset(y: isAnimation ? 0 : -40)
                    .opacity(isAnimation ? 1 : 0)
                    .animation(.easeOut(duration: 1), value: isAnimation)
                ZStack{
                    BackgroundImageView(Color: .white).offset(x: -imageOffest).blur(radius: imageOffest==0 ? 0 : 10)
                    
                    Image("character-1").resizable().scaledToFit()
                        .opacity(isAnimation ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimation)
                        .offset(x:imageOffest)
                        .rotationEffect(.degrees(imageOffest/20))
                        .gesture(DragGesture()
                            .onChanged({ gesture in if abs(imageOffest)<=150{ imageOffest=gesture.translation.width }})
                            .onEnded({ _ in withAnimation {imageOffest=0}})
                        )
                }.overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size:44,weight: .ultraLight ))
                        .foregroundColor(.white)
                        .opacity(imageOffest==0 ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(0.25), value: isAnimation)
                }
                
                Spacer()
                ZStack{
                    Capsule().fill(.white.opacity(0.2))
                    Capsule().fill(.white.opacity(0.2)).padding(8)
                    Text("Get Started").font(.system(.title3,design: .rounded)).bold().offset(x: 20)
                    
                    HStack{
                        Capsule().fill(Color("LightRed")).frame( width: buttonOffest+80)
                        Spacer()
                    }
                    HStack{
                        ZStack{
                            Circle().fill(Color("LightRed"))
                            Circle().fill(.black.opacity(0.2)).padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                            
                        }.frame(width: 80, height: 80)
                            .offset(x: buttonOffest)
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if (gesture.translation.width > 0) && (buttonOffest <= buttonWidth-80) {
                                            buttonOffest = gesture.translation.width
                                        }
                                    })
                                    .onEnded({ _ in
                                        withAnimation(Animation.easeOut(duration: 0.4)) {
                                            if buttonOffest > buttonWidth/2 {
                                                buttonOffest=buttonWidth-80
                                                AudioPlayer.playSound(sound: "success", type: "m4a")
                                                haptic.notificationOccurred(.success)
                                                isOnBoarding=false
                                                
                                            }else{
                                                haptic.notificationOccurred(.warning)
                                                buttonOffest=0
                                            }
                                        }
                                        
                                    })
                            )
                        Spacer()
                    }
                    
                    
                }.frame(height: 80).padding()
                    .foregroundColor(.white)
                    .offset(y: isAnimation ? 0 : 40)
                    .opacity(isAnimation ? 1 : 0)
                    .animation(.easeOut(duration: 1), value: isAnimation)
                
            }
            
        }.onAppear {
            isAnimation=true
        }.preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

struct TitleView: View {
    var imageOffest:Double
    var body: some View {
        VStack(spacing: 0){
            Text(imageOffest==0 ? "Share." : "Give.").font(.system(size: 60,weight: .heavy)).transition(.opacity).id(imageOffest)
            Text("""
            It's not how much we give but
            how much we love we put into giving
            """)
            .font(.title3).fontWeight(.light)
            .padding(.horizontal,10)
            .multilineTextAlignment(.center)
        }.foregroundColor(.white)
            .animation(.easeOut(duration: 1), value: imageOffest)
    }
}

struct BackgroundImageView: View {
    var Color:Color
    
    @State private var isAnimation=false
    var body: some View {
        ZStack{
            Circle().stroke(Color.opacity(0.2),lineWidth: 40)
            Circle().stroke(Color.opacity(0.2),lineWidth: 80)
        }
        .frame(width: 260,height: 260)
        .blur(radius: isAnimation ? 0 : 10)
        .opacity(isAnimation ? 1 : 0.5)
        .scaleEffect(isAnimation ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimation)
        .onAppear { isAnimation=true}
        
    }
}

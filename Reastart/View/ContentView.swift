//
//  ContentView.swift
//  Reastart
//
//  Created by Asem on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("OnBoarding") private var isOnBoarding = true
    var body: some View {
        if isOnBoarding {
            OnBoardingView()
        }else{
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

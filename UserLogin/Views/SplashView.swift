//
//  ContentView.swift
//  UserLogin
//
//  Created by Reenad gh on 27/05/1444 AH.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive : Bool
    
    var body: some View {
        VStack (spacing : 40){
            
            Image(systemName: "ladybug.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.pink)
           Text("please wait . .")
                .foregroundColor(.gray).bold()
                ProgressView()
                .scaleEffect(2)

        }
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: .constant(true))
    }
}

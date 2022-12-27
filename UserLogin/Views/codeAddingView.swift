//
//  codeAddingView.swift
//  UserLogin
//
//  Created by Reenad gh on 30/05/1444 AH.
//

import SwiftUI

struct codeAddingView: View {
    
    @EnvironmentObject var  vm  : FirebaseLogInManager

    var body: some View {
        VStack {
            Spacer()
            Text("enter code from sms")
            codeTextFiled()
            Button {
                vm.verifyToken()
                
            } label: {
                Text("log in")
            }
            Spacer()

        }
        .background(Color.white)
    }
}

struct codeAddingView_Previews: PreviewProvider {
    static var previews: some View {
        codeAddingView()
            .environmentObject(FirebaseUserManager())
    }
}

struct codeTextFiled: View {
    @EnvironmentObject var  vm  : FirebaseLogInManager

    var body: some View {
        HStack {
            TextField("enter code" , text: $vm.smsCode)
                .padding()
            
        }
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}

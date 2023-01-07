//
//  codeAddingView.swift
//  UserLogin
//
//  Created by Reenad gh on 30/05/1444 AH.
//

import SwiftUI

struct codeAddingView: View {
    
    @EnvironmentObject var  vm  : FirebaseLogInManager
    @State var smsCode : String = ""

    var body: some View {
        VStack {
            Spacer()
            Text("enter code from sms")
            codeTextFiled(smsCode: $smsCode)
            Button {
                vm.verifyToken(smsCode: smsCode )
                
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
    @Binding var smsCode : String

    var body: some View {
        HStack {
            TextField("enter code" , text: $smsCode)
                .padding()
            
        }
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}

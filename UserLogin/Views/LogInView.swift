//
//  LogInView.swift
//  UserLogin
//
//  Created by Reenad gh on 28/05/1444 AH.
//

import SwiftUI

struct LogInView: View {

    @StateObject var  vm  : FirebaseLogInManager = FirebaseLogInManager()
    var body: some View {
        
        
        VStack  (alignment: .center , spacing: 20){
            
            Text("Log In")
                .font(.largeTitle)
            MailTextFiledView()
            PasswordTextFiledView()
            Text("Or by phone number")
             PhoneTextFiledView()
            
            Button {
                vm.logInToAccount()
            } label: {
                Text("Log In")
                    .padding()
                    .padding(.horizontal, 40)
                    .foregroundColor(.pink)
                    .background(Color.pink.opacity(0.2))
                    .cornerRadius(12)
            }
            
            
            LogInStateView(loadingState: $vm.loadingState)
            
 
        }
        
        .overlay(
            ZStack {
    
                if let verificationID = vm.verificationID {
                    codeAddingView()
                    
                }
            }
            
        )
        
        .environmentObject(vm)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(FirebaseLogInManager())
            .environmentObject(FirebaseUserManager())

        
        LogInStateView(loadingState: .constant(.loading))
            .padding()
            .previewLayout(.sizeThatFits)
        
        
        MailTextFiledView()
            .padding()
            .previewLayout(.sizeThatFits)
        
    }
}

struct MailTextFiledView: View {
    @EnvironmentObject var  vm  : FirebaseLogInManager

    var body: some View {
        HStack {
            TextField("enter mail" , text: $vm.mail)
                .padding()
            
        }
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}

struct PhoneTextFiledView: View {
    
    @EnvironmentObject var  vm  : FirebaseLogInManager

    var body: some View {
        HStack (spacing : 0){
            Text("+966")
                .foregroundColor(.black).bold()
            TextField("phone" , text: $vm.phone)
                .keyboardType(.numberPad)
                .padding()
        }
        .padding(.horizontal , 10)

        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}

struct PasswordTextFiledView: View {
    @EnvironmentObject var  vm  : FirebaseLogInManager

    var body: some View {
        HStack {
            SecureField("enter password" , text: $vm.password)
                .padding()
            
        }
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}


struct LogInStateView: View {
    @Binding var loadingState : LoadingState

    var body: some View {
        switch loadingState {
        case .loading :
            ProgressView()
                .scaleEffect(1.5)
        case .failed(error: let error):
            Text(error)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.orange)
        case .none:
            Text("")
                
        case .success:
            Image(systemName: "checkmark.diamond.fill")
                .imageScale(.large)
                .foregroundColor(.green)
        }
    }
}

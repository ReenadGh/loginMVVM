//
//  LogInView.swift
//  UserLogin
//
//  Created by Reenad gh on 28/05/1444 AH.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var  vm: FirebaseLogInManager = FirebaseLogInManager()
    
    @State var mail: String = ""
    @State var password: String = ""
    @State var phone: String = ""
    
    var body: some View {
        
        VStack  (alignment: .center , spacing: 20) {
            
            Text("Log In")
                .font(.largeTitle)
            
            MailTextFiledView(mail: $mail)
            
            PasswordTextFiledView(password: $password)
            
            Text("Or by phone number")
            
            PhoneTextFiledView(phone: $phone)
            
            Button {
                vm.logInToAccount(mail: mail, password: password, phone: phone)
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
                if vm.hasVerificationID {
                    codeAddingView()
                }
            }
        )
        .environmentObject(vm)
    }
}

struct MailTextFiledView: View {

    @Binding var mail: String
    
    var body: some View {
        HStack {
            TextField("enter mail" , text: $mail)
                .padding()
            
        }
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}

struct PhoneTextFiledView: View {
    
    @Binding var phone: String
    
    var body: some View {
        HStack (spacing : 0){
            Text("+966")
                .foregroundColor(.black).bold()
            TextField("phone" , text: $phone)
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

    @Binding var password: String
    
    var body: some View {
        HStack {
            SecureField("enter password" , text: $password)
                .padding()
            
        }
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal , 50)
    }
}


struct LogInStateView: View {
    
    @Binding var loadingState: LoadingState

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




struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(FirebaseLogInManager())
            .environmentObject(FirebaseUserManager())


        
    
        
    }
}

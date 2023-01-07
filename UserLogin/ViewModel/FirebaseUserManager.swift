//
//  FirebaseUserManager.swift
//  UserLogin
//
//  Created by Reenad gh on 27/05/1444 AH.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift





protocol LoginProtocol: AnyObject {
    func logInToAccountByMail(mail: String, password: String)
    func logInToAccount(mail: String, password: String, phone: String)
    func logInToAccountByPhone(phone: String)
    func verifyToken(smsCode: String)
}



class FirebaseLogInManager :  ObservableObject {
    
 
    @Published var verificationID : String?
    @Published var loadingState : LoadingState = .none
    @Published var hasVerificationID = false

    let auth  : Auth
    
    init () {
        auth = Auth.auth()
    }
    
    
    func checkMail(mail: String) -> Bool {
        if mail.contains("@") {
            return true
        } else {
            return false
        }
    }
    
}

extension FirebaseLogInManager : LoginProtocol {
  
    
    
    
    func logInToAccountByMail(mail: String, password: String) {
        
        guard checkMail(mail: mail) else { return }
        
        self.loadingState = .loading
        auth.signIn(withEmail: mail, password: password ){ _ , error in
            if let error = error {
                print (error.localizedDescription)
                self.loadingState = .failed(error: error.localizedDescription)
                return
            }
            self.loadingState = .success
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingState = .none

            }
            
        }
        
    }
    
    func logInToAccount(mail: String, password: String, phone: String) {
        self.loadingState = .loading
      
        if ( mail.isEmpty || password.isEmpty ) , phone.isEmpty  {
            loadingState = .failed(error: "please fill mail or password filed ")
        }else if   mail.isEmpty ,  password.isEmpty , phone != ""  {
            logInToAccountByPhone(phone: phone)
        }else {
            logInToAccountByMail(mail: mail, password: password)
        }
        
    }

     func logInToAccountByPhone(phone : String ) {
        
        self.loadingState = .loading
        PhoneAuthProvider.provider()
          .verifyPhoneNumber("+966\(phone)", uiDelegate: nil) { verificationid, error in
              if let error = error {
                  self.loadingState = .failed(error: error.localizedDescription)
                  print(error.localizedDescription)
                return
              }
              self.verificationID =  verificationid ?? ""
              self.hasVerificationID = true
              
          }
        
    }
    
     func verifyToken(smsCode: String){
        self.loadingState = .loading

        guard let verificationID = verificationID else {
            self.loadingState = .failed(error: "try again later !")
            return
        }
         
         if !smsCode.isEmpty {
      print (smsCode)
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID , verificationCode: smsCode)
             
             auth.signIn(with: credential){ result , error in
                 if let error = error {
                self.loadingState = .failed(error: error.localizedDescription)
                return
            }
                 print (smsCode)

            self.loadingState = .success
                 print (smsCode)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingState = .none
                print (smsCode)

            }

            
        }
         }
        
        

    }
    
    
    
    
}

enum LoadingState  : Equatable {
    case loading
    case  success
    case failed(error : String)
    case none
}



protocol UserManagerProtocol {
    
    func fetchUser()
    func isUserLoggedin()-> Bool
    func signOutFromAccout()
}
class FirebaseUserManager : ObservableObject {
    
    @Published var user : User = .init()
    @Published var loadingState: LoadingState = .none
    
    let firestore : Firestore
    let auth  : Auth

      init () {
        auth = Auth.auth()
        firestore = Firestore.firestore()
         self.fetchUser()

    }
    
    

}

extension FirebaseUserManager : UserManagerProtocol {
    
    func fetchUser() {

        auth.addStateDidChangeListener { auth, user in
    
            guard let userId = user?.uid else {return}
            self.firestore.collection("users").document(userId).getDocument { documentSnapshot, error in
                if let error = error {
                    print("DEBUG : log in fetching user  : \(error.localizedDescription)")
                    return
                }
                
                guard let user = try? documentSnapshot?.data(as: User.self) else {return}
                self.user = user
            }
            
        }
        
    }
    

    func isUserLoggedin()-> Bool {
         !self.user.id.isEmpty
    }
    
    
    func signOutFromAccout() {
        do{
            try auth.signOut()
            user = .init()
        }catch {
            print(error)
        }
    }
    
    
    
}

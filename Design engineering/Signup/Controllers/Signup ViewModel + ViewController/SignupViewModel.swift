//
//  SignupViewModel.swift
//  Design engineering
//
//  Created by Mohamed Ali on 29/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel {
    var userNameBehaviour = BehaviorRelay<String>(value: "")
    var telehpneBehaviour = BehaviorRelay<String>(value: "")
    var emailBehaviour = BehaviorRelay<String>(value: "")
    var whatsappBehaviour = BehaviorRelay<String>(value: "")
    var fieldBehaviour = BehaviorRelay<String>(value: "")
    var cityBehaviour = BehaviorRelay<String>(value: "")
    var passwordBehaviour = BehaviorRelay<String>(value: "")
    var confirmpasswordBehaviour = BehaviorRelay<String>(value: "")
    var checkedAcceptBehaviour = BehaviorRelay<Bool>(value: false)
    
    var fieldsBehaviour = BehaviorRelay<[FieldsModel]>(value: [])
    
    
    // MARK: TODO: Make Validation Oberval here.
    var isuserNameBehaviour : Observable<Bool> {
        return userNameBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var istelephoneBehaviour : Observable<Bool> {
        return telehpneBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var isemailBehaviour : Observable<Bool> {
        return emailBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var iswhatsappBehaviour : Observable<Bool> {
        return whatsappBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var isfieldBehaviour : Observable<Bool> {
        return fieldBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var isCityBehaviour : Observable<Bool> {
        return cityBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var ispasswordBehaviour : Observable<Bool> {
        return passwordBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var isconfirmPasswordBehaviour : Observable<Bool> {
        return confirmpasswordBehaviour.asObservable().map { ob -> Bool in
            let result = ob.trimmingCharacters(in: .whitespaces).isEmpty
            
            return result
        }
    }
    
    var isSignupButtonEnabled: Observable<Bool> {
        return Observable.combineLatest(isuserNameBehaviour,istelephoneBehaviour,isemailBehaviour,iswhatsappBehaviour,isfieldBehaviour,isCityBehaviour,ispasswordBehaviour,isconfirmPasswordBehaviour) {
            
            usernameEmpty , telephoneEmpty, emailEmpty, whatsappEmpty, fieldEmpty, cityEmpty, passwordEmpty, ConfirmPassword in
            
            let password = self.passwordBehaviour.value == self.confirmpasswordBehaviour.value ? true : false
            
            let login = !usernameEmpty && !telephoneEmpty && !emailEmpty && !whatsappEmpty && !fieldEmpty && !cityEmpty && !passwordEmpty && !ConfirmPassword && password && self.checkedAcceptBehaviour.value
            
            return login
        }
    }
    
    func SetCellSelected(ob: FieldsModel) {
        var arr = fieldsBehaviour.value
        
        for i in 0..<arr.count {
            if arr[i].id == ob.id {
                arr[i].checked = true
                fieldBehaviour.accept(arr[i].filedTitle)
            }
            else {
                arr[i].checked = false
            }
        }
        
        fieldsBehaviour.accept(arr)
    }
}

//
//  LoginViewModel.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 04/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    // beahvior Subject must got initial Value
    var emailBehavior                   = BehaviorRelay<String>(value: "")
    var passwordBehavior                = BehaviorRelay<String>(value: "")
    var loadingBehavior                 = BehaviorRelay<Bool>(value: false)
    
    // publish subject don't need to default value in the start , so i need him now
   private var loginModelSubject        = PublishSubject<BaseModel<UserData>>()

    // just to apply encapsulation concept
    var loginModelObservable:Observable<BaseModel<UserData>> {
        return loginModelSubject
    }
    
    var IsEmailValid:Observable<Bool>{
        return emailBehavior.asObservable().map { (email)->Bool in
            let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return !isEmailEmpty
        }
    }
        var IsPasswordValid:Observable<Bool>{
            return passwordBehavior.asObservable().map { (pass)->Bool in
                let isValidPassword = pass.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                return !isValidPassword
            }
        }
    
    var IsLoginBtnEnabled: Observable<Bool>{
        return Observable.combineLatest(IsEmailValid,IsPasswordValid) { (isEmailEmpty,isPhoneEmpty) in
            let loginValid = isEmailEmpty && isPhoneEmpty
            return loginValid
        }
    }
    
    func getUser(){
        loadingBehavior.accept(true)
        let param = [
            "username": emailBehavior.value,
            "password": passwordBehavior.value
        ] as! [String:AnyObject]
        
        ApiManager.instance.getPosts(methodType: .post, parameters: param, url: "https://kitaba.me/home/login/") {[weak self]
            (Model: BaseModel<UserData>? , err : String? )in

            guard let self = self else {return}
            self.loadingBehavior.accept(false)
                        if  err != nil {

                            //  Completion(nil,"noNet")
                            if err == "noNet" {
                                // self.show_NoDataView(View: self.view)
                                print("----------------->No net")

                            }else if err == "anError" {
                                //  self.show_AnErrorView(View: self.view)
                                print("an errrrorrrrrrrrrrrr")
                            }else {
                                print(err)
                            }

                        }else {
                            //MARK: - Move To home VC after Login
                            guard let model = Model else {return}
                            //set reposnse data to container i created
                            self.loginModelSubject.onNext(model)

    }

        }

        
    }
}


//
//  ViewController.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 04/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewControler: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let loginViewModel = LoginViewModel()
    
    // For MemoryManagmaent Rea son
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindfTextFieldToViewModel()
        subscribeToLoginEnabled()
        subScribeToLoading()
        subscribeToResponseData()
        subScribeToLoginBtnToViewModel()
    }
    
    func bindfTextFieldToViewModel(){
        // binding textField with the Object Related on View model with RX
        emailTextField.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    
    func subscribeToLoginEnabled(){
        loginViewModel.IsLoginBtnEnabled.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        if loginBtn.isEnabled{
            print("enable")
        }else{
            print("not enable")
        }
    }
    
    // listen to LoadingBehavior Value
    func subScribeToLoading(){
        loginViewModel.loadingBehavior.subscribe(onNext:{ [weak self] (ISLoading) in
            guard let self = self else {return}
            if ISLoading {
                self.showIndicator(withTitle: "", and: "")
            }else{
                self.hideIndicator()
            }
        })
    }
    
    
    // listen to Data is back From Service 
    func subscribeToResponseData(){
        loginViewModel.loginModelObservable.subscribe(onNext:  {[weak self] (dataResponse) in
            guard let self = self else {return}
            if dataResponse.value! {
                if let homeVC = UIStoryboard(name: "BranchesStoryBorad", bundle: nil).instantiateViewController(withIdentifier: "Branches") as? Branches {
                   self.present(homeVC, animated: true)
                }
            }else{
                print(dataResponse.message!)
            }
        }).disposed(by: disposeBag)
    }
    
    // listen To login btn
    func subScribeToLoginBtnToViewModel(){
        loginBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self] data in
                guard let self = self else{return}
                // call api to get user data
                self.loginViewModel.getUser()
            }.disposed(by: disposeBag)
        
    }
}


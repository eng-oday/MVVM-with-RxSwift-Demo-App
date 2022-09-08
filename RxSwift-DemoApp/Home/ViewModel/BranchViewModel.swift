//
//  BranchViewModel.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 05/09/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire



class BranchesViewModel {
    
    
    let loadinBehavior = BehaviorRelay<Bool>(value: false)
            
    private var BranchModelSubject =  PublishSubject<[Branch]>()
    var BranchDataObservable:Observable<[Branch]>{
        return BranchModelSubject
    }
    
    private var IstableHidden = BehaviorRelay<Bool>(value: false)
    
    var IstableHiddenObservable:Observable<Bool>{
        return IstableHidden.asObservable()
    }
    
    
    func getData(){
        
        loadinBehavior.accept(true)
        ApiManager.instance.getPosts(methodType: .get, parameters: nil, url: "https://b-andsweets.com/api/list-branches") { [weak self](branchesModel: BranchesModel?, errorModel) in
            guard let self = self else { return }
            self.loadinBehavior.accept(true)
            if let error = errorModel {
                print(error)
            } else if let errorModel = errorModel {
                print(errorModel ?? "")
            } else {
                guard let branchesModel = branchesModel else { return }
                if branchesModel.data?.count ?? 0 > 0 {
                    self.BranchModelSubject.onNext(branchesModel.data ?? [])
                    self.IstableHidden.accept(false)
                } else {
                    self.IstableHidden.accept(true)
                }
            }
            
        }
    }
    
}


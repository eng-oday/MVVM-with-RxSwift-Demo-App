//
//  Branches.swift
//  RxSwift-DemoApp
//
//  Created by Oday Dieg on 05/09/2022.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa


class Branches: UIViewController {
    @IBOutlet weak var emptyBranchView: UIView!
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var branchesTableView: UITableView!
    
    
    let branchTableViewCellIdentifier = "BranchTableViewCell"
    let branchesViewModel = BranchesViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToHiddenTable()
        setupTableView()
        subscribeToResponse()
        getBranches()
        subscribeToLoading()
        subscribeToResponse()
    }
    func setupTableView() {
        branchesTableView.dataSource = nil
        branchesTableView.delegate = nil
        branchesTableView.register(UINib(nibName: branchTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: branchTableViewCellIdentifier)
    }

    func bindToHiddenTable() {
        branchesViewModel.IstableHiddenObservable.bind(to: self.branchView.rx.isHidden).disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        branchesViewModel.loadinBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        self.branchesViewModel.BranchDataObservable
            .bind(to: self.branchesTableView
                .rx
                .items(cellIdentifier: branchTableViewCellIdentifier,
                       cellType: branchTableViewCell.self)) { row, branch, cell in
                        print(row)
                        cell.textLabel?.text = branch.name
        }
        .disposed(by: disposeBag)
    }
    func getBranches() {
        branchesViewModel.getData()
    }
}

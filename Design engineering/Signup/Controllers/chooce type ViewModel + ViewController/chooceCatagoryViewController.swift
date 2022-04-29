//
//  ViewController.swift
//  Design engineering
//
//  Created by Mac on 27/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class chooceCatagoryViewController: UIViewController {
    
    @IBOutlet weak var workerView: UIView!
    @IBOutlet weak var workerLabel: UILabel!
    @IBOutlet weak var BusinessView: UIView!
    @IBOutlet weak var BusinessLabel: UILabel!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var adminView: UIView!
    @IBOutlet weak var adminLabel: UILabel!
    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var customerLabel: UILabel!
    
    let disposebag = DisposeBag()
    let choocecategoryviewmodel = chooceCategoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SubscribeToWorkerTouched()
        SubscribeToBusinessTouched()
        SubscribeToComopanyTouched()
        SubscribeToAdminTouched()
        SubscribeToCustomerTouched()
    }
    
    
    func SubscribeToWorkerTouched() {
        choocecategoryviewmodel.AddGuester(view: workerView) { [weak self] response in
            guard let self = self else { return }
            if response {
                self.updateUI(view: self.workerView, label: self.workerLabel)
            }
        }
    }
    
    func SubscribeToBusinessTouched() {
        choocecategoryviewmodel.AddGuester(view: BusinessView) { [weak self] response in
            guard let self = self else { return }
            if response {
                self.updateUI(view: self.BusinessView, label: self.BusinessLabel)
            }
        }
    }
    
    func SubscribeToComopanyTouched() {
        choocecategoryviewmodel.AddGuester(view: companyView) { [weak self] response in
            guard let self = self else { return }
            if response {
                self.updateUI(view: self.companyView, label: self.companyLabel)
            }
        }
    }
    
    func SubscribeToAdminTouched() {
        choocecategoryviewmodel.AddGuester(view: adminView) { [weak self] response in
            guard let self = self else { return }
            if response {
                self.updateUI(view: self.adminView, label: self.adminLabel)
            }
        }
    }
    
    func SubscribeToCustomerTouched() {
        choocecategoryviewmodel.AddGuester(view: customerView) { [weak self] response in
            guard let self = self else { return }
            if response {
                self.updateUI(view: self.customerView, label: self.customerLabel)
            }
        }
    }
    
    private func updateUI(view: UIView, label: UILabel) {
        let views = [workerView, BusinessView, companyView, adminView , customerView]
        
        let labels = [workerLabel,BusinessLabel,companyLabel,adminLabel,customerLabel]
        
        views.forEach {
            if $0 == view {
                guard let allView = $0 else { return }
                allView.layer.borderColor = UIColor().hexStringToUIColor(hex: "#D94E28").cgColor
                allView.layer.borderWidth = 2
                allView.layer.masksToBounds = true
                allView.layer.backgroundColor = UIColor().hexStringToUIColor(hex: "#DFDEDC").cgColor
            }
            else {
                guard let allView = $0 else { return }
                
                allView.layer.borderColor = UIColor.lightGray.cgColor
                allView.layer.borderWidth = 1
                allView.layer.masksToBounds = true
                allView.layer.backgroundColor = UIColor().hexStringToUIColor(hex: "#FFFFFF").cgColor
                allView.layer.shadowRadius = 10
                allView.layer.shadowColor = UIColor().hexStringToUIColor(hex: "#000000").cgColor
                allView.layer.shadowOpacity = 1
                allView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
                allView.layer.cornerRadius = 10
                
            }
        }
        
        labels.forEach {
            if $0 == label {
                $0?.textColor = UIColor().hexStringToUIColor(hex: "#eb552c")
                $0?.backgroundColor = .clear
            }
            else {
                $0?.textColor = UIColor().hexStringToUIColor(hex: "#2c4b5f")
            }
        }
    }

}


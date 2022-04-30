//
//  SignupTableViewController.swift
//  Design engineering
//
//  Created by Mohamed Ali on 29/04/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class SignupTableViewController: UITableViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jobProfileView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var whatsappTextField: UITextField!
    @IBOutlet weak var fieldTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var showPassword1: UIButton!
    @IBOutlet weak var showPassword2: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var FieldstableView: UITableView!
    
    let disposebag = DisposeBag()
    let signupviewmodel = SignupViewModel()
    let NibfileName = "FieldCell"
    let CellIndetifier = "Cell"
    let padding = 30
    let animationTime = 0.7
    
    var ob: SignupModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        ConfigureTextFieldUI()
        LoadData()
        BindToTextField()
        BindToNextTextField()
        SubscribeToEnableEditButton()
        SubscribeToEditButtonAction()
        SubscribeToBackButtonAction()
        
        SubscribeTotouchFieldTextField()
        SubscribeTotouchViewToDismiss()
        ConfigureTableView()
        SubscribeToTableView()
        SubscribeToSelectEmlemnt()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 32
    }
    
    @IBAction func ShowPassword (_ sender: UIButton) {
        
        if sender.tag == 1 {
            ChangeStatus(sender, passwordTextField)
        }
        else {
            ChangeStatus(sender, confirmPasswordTextField)
        }
        
    }
    
    @IBAction func checkMarkAction (_ sender: UIButton) {
        ChangeStatus(sender, nil)
    }
    
    func ConfigureTextFieldUI() {
        userNameTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
        telephoneTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
        emailTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
        whatsappTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
        fieldTextField.setPadding(paddingValue: padding, PlaceHolder: "اختار التخصص", Color: UIColor().hexStringToUIColor(hex: "#2C4B5F"))
        cityTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
        passwordTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
        confirmPasswordTextField.setPadding(paddingValue: padding, PlaceHolder: "", Color: .clear)
    }
    
    func BindToTextField() {
        userNameTextField.rx.text.orEmpty.bind(to: signupviewmodel.userNameBehaviour).disposed(by: disposebag)
        telephoneTextField.rx.text.orEmpty.bind(to: signupviewmodel.telehpneBehaviour).disposed(by: disposebag)
        emailTextField.rx.text.orEmpty.bind(to: signupviewmodel.emailBehaviour).disposed(by: disposebag)
        whatsappTextField.rx.text.orEmpty.bind(to: signupviewmodel.whatsappBehaviour).disposed(by: disposebag)
        fieldTextField.rx.text.orEmpty.bind(to: signupviewmodel.fieldBehaviour).disposed(by: disposebag)
        cityTextField.rx.text.orEmpty.bind(to: signupviewmodel.cityBehaviour).disposed(by: disposebag)
        passwordTextField.rx.text.orEmpty.bind(to: signupviewmodel.passwordBehaviour).disposed(by: disposebag)
        confirmPasswordTextField.rx.text.orEmpty.bind(to: signupviewmodel.confirmpasswordBehaviour).disposed(by: disposebag)
    }
    
    func BindToNextTextField() {
        userNameTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.telephoneTextField.becomeFirstResponder()
        }).disposed(by: disposebag)
        
        telephoneTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.emailTextField.becomeFirstResponder()
        }).disposed(by: disposebag)
        
        
        emailTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.whatsappTextField.becomeFirstResponder()
        }).disposed(by: disposebag)
        
        whatsappTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.whatsappTextField.resignFirstResponder()
            UIView.animate(withDuration: TimeInterval(self.animationTime)) {
                self.view2.isHidden = false
                self.view3.isHidden = false
                self.view.layoutIfNeeded()
            }
            
        }).disposed(by: disposebag)
        
        cityTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.passwordTextField.becomeFirstResponder()
        }).disposed(by: disposebag)
        
        passwordTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.confirmPasswordTextField.becomeFirstResponder()
        }).disposed(by: disposebag)
        
        confirmPasswordTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.confirmPasswordTextField.resignFirstResponder()
        }).disposed(by: disposebag)
    }
    
    func LoadData() {
        logoImageView.image = ob?.jobImage
        titleLabel.text = ob?.jobTitle
        signupviewmodel.fieldsBehaviour.accept(ob!.fields)
    }
    
    func SubscribeToBackButtonAction() {
        BackButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposebag)
    }
    
    func SubscribeToEnableEditButton() {
        signupviewmodel.isSignupButtonEnabled.subscribe(onNext: { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.SendButton.isEnabled = true
            }
            else {
                self.SendButton.isEnabled = false
            }
        }).disposed(by: disposebag)
    }
    
    func SubscribeToEditButtonAction() {
        SendButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { _ in
            print("Send Success!!")
        }).disposed(by: disposebag)
    }
    
    func SubscribeTotouchFieldTextField() {
        fieldTextField.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            
            self?.fieldTextField.resignFirstResponder()
            UIView.animate(withDuration: TimeInterval(self!.animationTime)) {
                self?.view2.isHidden = false
                self?.view3.isHidden = false
                self?.view.layoutIfNeeded()
            }
        }).disposed(by: disposebag)
    }
    
    func SubscribeTotouchViewToDismiss() {
        view2.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            UIView.animate(withDuration: TimeInterval(self!.animationTime)) {
                self?.view2.isHidden = true
                self?.view3.isHidden = true
                self?.view.layoutIfNeeded()
            }
        }).disposed(by: disposebag)
    }
    
    func ConfigureTableView() {
        FieldstableView.register(UINib(nibName: NibfileName, bundle: nil), forCellReuseIdentifier: CellIndetifier)
        FieldstableView.rowHeight = FieldstableView.frame.size.height / 3
    }
    
    func SubscribeToTableView() {
        signupviewmodel.fieldsBehaviour.bind(to: FieldstableView.rx.items(cellIdentifier: CellIndetifier, cellType: FieldCell.self)) {
            row , branch , cell in
            cell.ConfigureCell(field: branch)
        }.disposed(by: disposebag)
    }
    
    func SubscribeToSelectEmlemnt() {
        Observable
                .zip(FieldstableView.rx.itemSelected, FieldstableView.rx.modelSelected(FieldsModel.self))
                .bind { [weak self] selectedIndex, branch in
                    
                    guard let self = self else{ return }
                    print("Selected Success!!")
                    self.signupviewmodel.SetCellSelected(ob: branch)
                    self.fieldTextField.text = self.signupviewmodel.fieldBehaviour.value
                    self.view2.isHidden = true
                    self.view3.isHidden = true
                    
            }
            .disposed(by: disposebag)
    }
    
    private func ChangeStatus(_ sender: UIButton, _ text: UITextField?) {
        
        if sender.isSelected {
            sender.isSelected = false
            if let text = text {
                text.isSecureTextEntry = true
            }
            else {
                signupviewmodel.checkedAcceptBehaviour.accept(false)
            }
            
        }
        else {
            sender.isSelected = true
            if let text = text {
                text.isSecureTextEntry = false
            }
            else {
                signupviewmodel.checkedAcceptBehaviour.accept(true)
            }
            
        }
    }
}

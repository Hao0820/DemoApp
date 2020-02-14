//
//  SearchVC.swift
//  Test App
//
//  Created by Wesley on 2020/2/13.
//  Copyright © 2020 Wesley. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    
    lazy var ContentTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .left
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 35))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.placeholder = "欲搜尋內容"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var PageNumTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .left
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 35))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.placeholder = "每頁呈現數量"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("搜尋", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: #selector(BtnTap), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        view.addSubview(btn)
        return btn
    }()
    
    var CancelKeyBoardTap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setKeyBoard()
     
        //Do any additional setup after loading the view.
    }
    
    func initView() {
        self.title = "搜尋輸入頁"
        view.backgroundColor = .white
        view.addSubview(btn)
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor , constant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(PageNumTextField)
        PageNumTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PageNumTextField.bottomAnchor.constraint(equalTo: btn.topAnchor , constant: -20).isActive = true
        PageNumTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        PageNumTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        PageNumTextField.addTarget(self, action: #selector(textFieldValueChange), for: .editingChanged)
        view.addSubview(ContentTextField)
        ContentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ContentTextField.bottomAnchor.constraint(equalTo: PageNumTextField.topAnchor , constant: -20).isActive = true
        ContentTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        ContentTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ContentTextField.addTarget(self, action: #selector(textFieldValueChange), for: .editingChanged)
    }
    
    
    
    @objc func BtnTap() {
        
        self.view.endEditing(true)
        
        guard let num = PageNumTextField.text , let Num = Int(num) , Num > 0 else {
            let alertController = UIAlertController(title: nil, message: "請輸入正確數量", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default) { (action) in
                self.PageNumTextField.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        PageNum = num
        Content = ContentTextField.text!
        
        navigationController?.pushViewController(TabBarController(), animated: true)
        
    }
    
}

extension SearchVC: UITextFieldDelegate {
    
    func setKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        CancelKeyBoardTap = UITapGestureRecognizer.init(target: self, action: #selector(handleSingleTap))
        
        ContentTextField.delegate = self
        PageNumTextField.delegate = self
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case ContentTextField:
            PageNumTextField.becomeFirstResponder()
        case PageNumTextField:
            BtnTap()
        default:
            break
        }
        
        return true
    }
    
   @objc func textFieldValueChange(_ textField: UITextField) {
        if ContentTextField.text != "" , PageNumTextField.text != "" {
            btn.isEnabled = true
            btn.backgroundColor = .black
        } else {
            btn.isEnabled = false
            btn.backgroundColor = .gray
        }
    }
    
  
    
    
    @objc  func keyboardWasShown(){
        self.view.addGestureRecognizer(CancelKeyBoardTap)
    }
    
    @objc func keyboardWasHidden(){
        self.view.removeGestureRecognizer(CancelKeyBoardTap)
    }
    
    @objc func handleSingleTap(){
        self.view.endEditing(true)
        
    }
    
    
}

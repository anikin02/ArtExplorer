//
//  AddCollectionViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 10.04.2024.
//

import UIKit
import SnapKit

class AddCollectionViewController: UIViewController {
  private let buttonSave = UIButton()
  private let nameTextField = UITextField()
  private let titleLabel = UILabel()
  
  var onSave: ((String) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
    generateView()
  }
  
  private func generateView() {
    titleLabel.text = "Create new collection"
    titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.snp.top).offset(20)
      make.left.equalTo(view.snp.left).offset(20)
    }
    
    nameTextField.text = "Name collection"
    nameTextField.layer.borderWidth = 1.0
    nameTextField.layer.borderColor = UIColor.black.cgColor
    let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
    nameTextField.leftView = leftPaddingView
    nameTextField.leftViewMode = .always
    nameTextField.layer.cornerRadius = 5.0
    
    nameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)

    view.addSubview(nameTextField)
    
    nameTextField.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(50)
      make.left.equalTo(view.snp.left).offset(20)
      make.width.equalToSuperview().offset(-40)
      make.height.equalTo(40)
    }
    
    buttonSave.setTitle("Save", for: .normal)
    buttonSave.backgroundColor = .systemPink
    buttonSave.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    view.addSubview(buttonSave)
    
    buttonSave.snp.makeConstraints { make in
      make.top.equalTo(nameTextField.snp.bottom).offset(80)
      make.centerX.equalTo(view.snp.centerX)
      make.width.equalTo(80)
    }
    
  }
  
  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
      textField.text = ""
  }
  
  @objc func saveButtonTapped() {
      onSave?(nameTextField.text ?? "")
      dismiss(animated: true)
  }
}

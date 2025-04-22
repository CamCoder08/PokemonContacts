//
//  AddContactViewController.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/22/25.
//

import UIKit

class AddContactViewController: UIViewController {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true // 이미지 크기가 뷰를 초과할 경우 잘라냄
        imageView.backgroundColor = UIColor.systemGray
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        return imageView
    }()

    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "이름을 입력하세요"
        nameTextField.borderStyle = .roundedRect // 텍스트필드 테두리
        return nameTextField
    }()

    let phoneNumberTextField: UITextField = {
        let phoneNumberTextField = UITextField()
        phoneNumberTextField.placeholder = "전화번호를 입력하세요"
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.keyboardType = .numberPad
        return phoneNumberTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()

    }

    private func setNavigationBar() {
        title = "연락처 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
    }

    @objc private func applyButtonTapped() {
        print("적용 버튼 테스트")
    }

    private func setUI() {

        [profileImageView, nameTextField, phoneNumberTextField].forEach { view.addSubview($0) }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(160)
        }

        nameTextField.snp.makeConstraints { make in // 일단 대충 잡기
            make.top.equalTo(profileImageView.snp.bottom).offset(140)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }

        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.left.right.height.equalTo(nameTextField)
        }
    }



}

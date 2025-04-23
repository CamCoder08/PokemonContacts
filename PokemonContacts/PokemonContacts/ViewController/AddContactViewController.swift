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

    let randomImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(fetchRandomPokemonImage), for: .touchUpInside)
        return button
    }()

    var currentImageURL: String?

    override func viewDidLoad() {
        view.backgroundColor = .white
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
        guard let name = nameTextField.text, !name.isEmpty else {
            print("이름이 비었습니다")
            return
        }

        guard let phone = phoneNumberTextField.text, !phone.isEmpty else {
            print("전화번호가 비었습니다.")
            return
        }

        let imageURL = currentImageURL ?? ""

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate 접근 실패")
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        let newContact = ContactEntity(context: context)

        newContact.name = name
        newContact.phoneNumber = phone
        newContact.imageURL = imageURL

        do {
            try context.save()
            print("연락처 저장 성공")

            navigationController?.popViewController(animated: true)
        } catch {
            print("연락처 자장 실패")
        }
    }

    private func setUI() {

        [profileImageView, nameTextField, phoneNumberTextField, randomImageButton].forEach { view.addSubview($0) }

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

        randomImageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
    }

    @objc private func fetchRandomPokemonImage() {
        PokemonAPI.fetchRandomPokemon { [weak self] result in

            guard let self = self, let pokemon = result else {
                print("데이터 로드 실패")
                return
            }

            guard let imageURL = URL(string: pokemon.sprites.frontDefault) else {
                print("이미지 URL 변환 실패")
                return
            }

            URLSession.shared.dataTask(with: imageURL) { data, response, error in

                guard let data = data, error == nil else {
                    print("이미지 다운로드 실패")
                    return
                }

                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            }.resume()
        }
    }
}

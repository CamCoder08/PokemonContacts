//
//  AddContactViewController.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/22/25.
//

import UIKit

class AddContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

    }

    private func setNavigationBar() {
        title = "연락처 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
    }

    @objc private func applyButtonTapped() {
        print("적용 버튼 테스트")
    }




}

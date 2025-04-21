//
//  ContactTableViewCell.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/21/25.
//

import UIKit
import SnapKit

class ContactTableViewCell: UITableViewCell {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true // 이미지 크기가 뷰를 초과할 경우 잘라냄
        imageView.backgroundColor = UIColor.systemGray
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "변준영"
        return label
    }()

    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "010-6663-4458"
        return label
    }()


    // 커스텀 셀을 만들 때 실행되는 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupLayout()
    }

    // 코드베이스로 진행할 경우 작성
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() { // 일단 대략적으로 세팅
        [profileImageView, nameLabel, phoneNumberLabel].forEach { addSubview($0) }

        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50) // 원형을 위해 정사각형 만들어야함
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }

        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalTo(nameLabel)
        }


    }


}

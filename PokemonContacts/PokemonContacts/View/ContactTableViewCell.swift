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
//        imageView.backgroundColor = UIColor.systemGray
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()


    // 커스텀 셀을 만들 때 실행되는 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }

    // 코드베이스로 진행할 경우 작성
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() { // 일단 대략적으로 세팅
        [profileImageView, nameLabel, phoneNumberLabel].forEach { addSubview($0) }

        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50) // 원형을 위해 정사각형 만들어야함
        }

        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profileImageView.snp.right).offset(25)
            make.right.equalToSuperview().inset(16)
        }

        phoneNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(35)
        }


    }


}

//
//  ViewController.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/21/25.
//

import UIKit
import SnapKit

class PokemonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contactList: [ContactEntity] = []

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContacts()
    }

    private func fetchContacts() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate 접근 실패")
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = ContactEntity.fetchRequest()

        do {
            let contactEntities = try context.fetch(fetchRequest)

            contactList = contactEntities

            tableView.reloadData()
            
        } catch {
            print("데이터 불러오기 실패")
        }
    }

    private func setupNavigationBar() {
        title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }

    @objc private func addButtonTapped() {
        let addViewController = AddContactViewController()
        navigationController?.pushViewController(addViewController, animated: true)
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in // 일단 대충 잡기
            make.edges.equalToSuperview()
        }

        tableView.dataSource = self // 데이터 표시 주체는 이 뷰컨
        tableView.delegate = self // 선택, 행동 처리의 주체도 뷰컨

        tableView.rowHeight = 80
        tableView.separatorStyle = .singleLine // 구분선

        // 커스텀셀을 테이블뷰에 등록
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactCell")
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }

        let contact = contactList[indexPath.row]

        cell.nameLabel.text = contact.name
        cell.phoneNumberLabel.text = contact.phoneNumber

        if let imageURL = contact.imageURL, let url = URL(string: imageURL) {

            URLSession.shared.dataTask(with: url) { data, response, error in

                guard let data = data, error == nil else {
                    print("이미지 다운로드 실패")
                    return
                }

                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.profileImageView.image = image
                    }
                }
            }.resume()
        } else {
            cell.profileImageView.image = UIImage(named: "placeholder")
        }

        return cell

    }
}


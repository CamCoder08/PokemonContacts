//
//  ViewController.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/21/25.
//

import UIKit
import SnapKit

class PokemonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contactList: [Contact] = []
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()
        setupTableView()
        setupDummyData()
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

            contactList = contactEntities.map {
                Contact(name: $0.name ?? "", phoneNumber: $0.phoneNumber ?? "", imageURL: $0.imageURL ?? "")
            }

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


    private func setupDummyData() {
        contactList = [
        Contact(name: "준영", phoneNumber: "010-6663-4458", imageURL: ""),
        Contact(name: "승호", phoneNumber: "010-9328-4985", imageURL: ""),
        Contact(name: "이호", phoneNumber: "010-2520-4279", imageURL: ""),
        Contact(name: "종호", phoneNumber: "010-7479-9850", imageURL: ""),
        Contact(name: "희원", phoneNumber: "010-5742-2668", imageURL: "")
        ]
        tableView.reloadData()
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

        return cell

    }
}


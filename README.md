# PokemonContacts

---

## 1. 과제 및 프로젝트 개요

**PokemonContacts**는 UIKit 기반의 연락처 앱으로, 사용자가 이름과 전화번호를 입력하고, 포켓몬 API에서 가져온 **랜덤한 프로필 이미지를 설정**하여 CoreData에 저장하고, 저장된 연락처를 리스트 형태로 보여주는 앱입니다.

이 앱은 UIKit을 활용한 코드 기반 UI 구현과 함께, iOS 앱 개발의 핵심 개념인 **네트워크 통신, 화면 전환, CoreData** 등을 실습하기 위한 목적으로 설계되었습니다.

---

## 2. 사용 기술 및 구조

| 항목 | 설명 |
|------|------|
| Language | Swift |
| UI Framework | UIKit + SnapKit (AutoLayout) |
| 데이터 저장 | CoreData |
| 네트워크 통신 | URLSession |
| API 사용 | PokeAPI – 랜덤 포켓몬 이미지 불러오기 |
| 화면 구성 | 코드 기반 UI (Storyboard 사용 안 함) |
| 아키텍처 구조 | ViewController, View, Model, Network, CoreData 모듈 분리 |
|----------------------|------------------------------------------------------------------------------------------------------------|

---

## 3. 프로젝트 파일 디렉토리

```
PokemonContacts/
├── AppDelegate.swift
├── SceneDelegate.swift
├── LaunchScreen.storyboard
├── Assets.xcassets
├── Info.plist

├── Model/
│   ├── ContactEntity+CoreDataClass.swift
│   ├── ContactEntity+CoreDataProperties.swift
│   ├── PokemonContacts.xcdatamodeld
│   └── PokemonModel.swift

├── Network/
│   └── PokemonAPI.swift

├── View/
│   └── ContactTableViewCell.swift

├── ViewController/
│   ├── AddContactViewController.swift
│   └── PokemonListViewController.swift

Package Dependencies/
└── SnapKit 5.7.1
```

---

## 4. 앱 주요화면

![무제 001](https://github.com/user-attachments/assets/40280cbf-78ec-49ed-b6d2-283c4a1d89e7)

---

## 5. 프로젝트를 통해 배운 점

이번 프로젝트를 통해 단순한 UI 구현을 넘어  
Swift와 UIKit을 활용한 **앱 전체 흐름**을 설계하고 구현해보는 귀중한 경험을 얻었습니다.

- **API 호출과 디코딩 흐름**을 익혔습니다. URLSession을 통해 PokeAPI에 요청을 보내고, 응답받은 JSON을 `Codable` 모델로 변환하여 실제 이미지 URL을 추출해 사용하는 과정을 직접 구현했습니다.

- **CoreData의 저장과 불러오기 구조**를 정확히 이해하게 되었습니다. 데이터를 저장했다고 끝나는 것이 아니라, 저장된 데이터를 fetch하고, 이를 배열에 반영하고, 다시 테이블 뷰를 리로드해 화면에 보여주는 전체 과정을 체득했습니다.

- **옵셔널 바인딩의 필요성**을 직접 경험했습니다. `String?` 타입을 `URL(string:)`에 바로 넣을 수 없다는 오류를 통해 `guard let`, `if let`을 사용해 안정적으로 처리하는 방법을 익혔습니다.

- **클로저 안에서 self를 사용할 때는 lazy var로 선언해야 하는 이유**를 직접 앱 크래시를 겪으며 체험했습니다. let으로 선언된 버튼에서 self를 참조할 경우 앱이 종료되는 현상을 통해 Swift의 초기화 타이밍 개념을 이해하게 되었습니다.

- **viewWillAppear의 용도**를 명확히 이해했습니다. 화면이 다시 나타날 때마다 데이터를 새로 불러와야 하므로, `viewDidLoad`가 아닌 `viewWillAppear`에서 `fetchContacts()`를 호출해 최신 데이터를 반영하는 흐름을 구현했습니다.

---

## 6. 마무리 회고

이 프로젝트는 단순한 기능 구현을 넘어, iOS 앱이 어떻게 데이터를 다루고, 사용자 흐름에 따라 UI와 로직이 맞물려 작동하는지를 처음부터 끝까지 설계해보는 소중한 기회였습니다.

작은 UI 컴포넌트를 설계하는 일부터 네트워크 요청, CoreData 저장, 화면 반영까지 모든 과정을 직접 구현하면서, Swift와 UIKit에 대해 더욱 심도 깊은 학습을 하게 되었습니다.

앞으로는 기능 구현뿐 아니라, **코드 구조와 책임 분리**, **데이터 흐름의 명확한 파악**, **사용자 경험을 고려한 UI 반영 시점 제어**까지 모두 고려하도록 노력하고 복습하고자 합니다.

감사합니다.


---


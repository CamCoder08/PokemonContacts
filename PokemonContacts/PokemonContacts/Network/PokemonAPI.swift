//
//  PokemonAPI.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/22/25.
//

import Foundation

class PokemonAPI {
    // URLSession을 사용한 포켓몬 API 요청(request) 함수
    static func fetchRandomPokemon(completion: @escaping (Pokemon?) -> Void) {

        let randomID = Int.random(in: 1...1000) // ID로 쓰일 랜덤 넘버 생성

        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)" // randomID가 적용된 주소

        guard let url = URL(string: urlString) else { // 타입변환
            print("URL이 잘못 되었습니다.")
            completion(nil)
            return
        }
        // url이 담겨져있는 url을 URLRequest 타입으로 만들어서 저장해줘.
        let request = URLRequest(url: url)

        // 기본 설정의 URLSession 인스턴트를 생성하고 session에 저장해줘.
        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, response, error in // 네트워크 요청을 보냄

            guard let data = data, error == nil else { // 데이터가 있는지, 에러가 없는지 체크
                print("데이터 로드 실패")
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, // response가 HTTP 응답이면 httpResponse라는 상수로 써볼게
               (200..<300).contains(httpResponse.statusCode) { // 응답에 200~299 상태코드가 포함되어있니?

                do { // 시도
                    let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(decoded) // 디코딩 시도(try) data를 Pokemon 구조체에 맞춰서 디코딩해서 성공하면 저장

                } catch { // 실패하면 여기로 보내
                    print("JSON 디코딩 실패")
                    completion(nil)
                }
            } else { // 위 if let에서 상태코드가 잘못될 경우
                print("응답 실패")
                completion(nil)
            }

        }.resume()
    }
}

//
//  APIService.swift
//  Medications
//
//  Created by Mazharul on 23/4/25.
//


import Combine
import Foundation

protocol APIServiceProtocol {
    func fetchMedications(searchText: String) -> AnyPublisher<MedicationDTO, Error>
}

final class APIService: APIServiceProtocol {
    func fetchMedications(searchText: String)-> AnyPublisher<MedicationDTO, Error> {
        guard let encodedName = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                     let url = URL(string: "https://rxnav.nlm.nih.gov/REST/drugs.json?name=\(encodedName)&expand=psn") else {
                   return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
               }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MedicationDTO.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

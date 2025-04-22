//
//  MedicationViewModel.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

enum SearchState {
    case isLoading
    case empty
    case loaded
    case error(String)
    case isFirstTime
}

import Foundation
import Combine

class SearchMedicationsViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var conceptProperties: [ConceptProperty] = []
    @Published var searchState: SearchState = .isFirstTime
    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchQuery
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                if !text.isEmpty {
                    self.searchState = .isLoading
                    let searchText = text.lowercased()
                    self.fetchMedications(searchText: searchText)
                    //self.loadDummyData(searchText: searchText)
                }
            }
            .store(in: &cancellables)
    }

    private func loadDummyData(searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.conceptProperties = Medication.dummy.drugGroup?.conceptGroup?.flatMap { group in
                group.conceptProperties?.filter {
                    $0.name?.lowercased().contains(searchText) ?? false
                } ?? []
            } ?? []

            self.searchState = self.conceptProperties.isEmpty ? .empty : .loaded

        }
    }

    
    func fetchMedications(searchText: String) {
        let encodedName = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString = "https://rxnav.nlm.nih.gov/REST/drugs.json?name=\(encodedName)&expand=psn"
        guard let url = URL(string: urlString) else {
               self.searchState = .error("Invalid URL created with encoded name.")
               return
           }

        URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { data, _ in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("🔵 Raw JSON Response:")
                    print(jsonString)
                }
            })
            .map(\.data)
            .decode(type: Medication.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { decoded in
                print("🟢 Successfully Decoded RxNormResponse:")
                print(decoded)
            })
            .map { response in
                response.drugGroup?.conceptGroup?
                    .compactMap { $0.conceptProperties }
                    .flatMap { $0 } ?? []
            }

        
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.searchState = .error("Failed to load data: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] medications in
                guard let self = self else { return }
                self.conceptProperties = medications
                self.searchState = medications.isEmpty ? .empty : .loaded
            })

            .store(in: &cancellables)
    }
}

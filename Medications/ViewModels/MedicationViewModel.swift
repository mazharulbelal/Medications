//
//  MedicationViewModel.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//


import Foundation
import Combine

class SearchMedicationsViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var conceptProperties: [ConceptProperty] = []
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchQuery
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.conceptProperties = []
                    self.isLoading = false
                } else {
                    self.isLoading = true
                    self.loadDummyData()
                    // self.fetchMedications(for: text)
                }
            }
            .store(in: &cancellables)
    }

    // Simulate loading delay (optional, for better UX in mock mode)
    private func loadDummyData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.conceptProperties = Medication.dummy.drugGroup?.conceptGroup?.flatMap { group in
                group.conceptProperties?.filter {
                    $0.name?.lowercased().contains(self.searchQuery.lowercased()) ?? false
                } ?? []
            } ?? []

            self.isLoading = false
        }
    }

    // Real API
    func fetchMedications(for name: String) {
        guard !name.isEmpty else {
            conceptProperties = []
            isLoading = false
            return
        }

        isLoading = true
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://rxnav.nlm.nih.gov/REST/drugs.json?name=\(encodedName)&expand=psn"
        guard let url = URL(string: urlString) else { return }

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
            .handleEvents(receiveCompletion: { _ in
                self.isLoading = false
            })
            .replaceError(with: [])
            .assign(to: &$conceptProperties)
    }
}

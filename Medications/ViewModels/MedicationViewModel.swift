//
//  MedicationViewModel.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import Combine
import Foundation
import RealmSwift

enum SearchState {
    case isFirstTime
    case isLoading
    case empty
    case loaded
    case error(String)
}

final class MedicationViewModel: ObservableObject {
    @Published private(set) var conceptProperties: [ConceptPropertyDTO] = []
    @Published private(set) var myMedicationList: [ConceptPropertyDTO] = []
    @Published var searchState: SearchState = .isFirstTime
    private let medicationRepository: MedicationRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private let realm = try! Realm()
    
    init(repository: MedicationRepositoryProtocol = MedicationRepository()) {
        self.medicationRepository = repository
    }
    
    func loadMedication(searchText: String) {
        searchState = .isLoading
        medicationRepository.fetchMedications(searchText: searchText)
            .map { response in
                response.drugGroup?.conceptGroup?
                    .compactMap { $0.conceptProperties }
                    .flatMap { $0 } ?? []
            }
        
        
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.searchState = .error("Failed to load medication: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] medication in
                self?.conceptProperties = medication
                self?.searchState = medication.isEmpty ? .empty : .loaded
            })
            .store(in: &cancellables)
    }
    
    
    func saveToRealm(model: ConceptPropertyDTO) {
        do {
            try medicationRepository.saveMedication(model)
            loadSavedMedications()
        } catch {
            print("Error saving medication: \(error)")
        }
    }
    
    
    func loadSavedMedications() {
        let saved = medicationRepository.loadSavedMedications()
        DispatchQueue.main.async { [weak self] in
            self?.myMedicationList = saved
        }
    }

    
    func deleteMedication(_ conceptProperty: ConceptPropertyDTO) {
           do {
               try medicationRepository.deleteMedication(conceptProperty)
               loadSavedMedications()
           } catch {
               print("Error deleting medication: \(error)")
           }
       }
    
}







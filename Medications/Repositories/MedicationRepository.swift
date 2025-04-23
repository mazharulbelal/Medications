//
//  MedicationRepository.swift
//  Medications
//
//  Created by Mazharul on 23/4/25.
//


import Combine
import RealmSwift

protocol MedicationRepositoryProtocol {
    func fetchMedications(searchText: String) -> AnyPublisher<MedicationDTO, Error>
    func saveMedication(_ medication: ConceptPropertyDTO) throws
    func loadSavedMedications() -> [ConceptPropertyDTO]
}

final class MedicationRepository: MedicationRepositoryProtocol {
    private let apiService: APIServiceProtocol
    private let realm = try! Realm()

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchMedications(searchText: String) -> AnyPublisher<MedicationDTO, Error> {
        apiService.fetchMedications(searchText: searchText)
    }

    func saveMedication(_ medication: ConceptPropertyDTO) throws {
        let entity = ConceptPropertyEntity(from: medication)
        try realm.write {
            realm.add(entity, update: .modified)
        }
    }
    
    func loadSavedMedications() -> [ConceptPropertyDTO] {
            let savedMedications = realm.objects(ConceptPropertyEntity.self)
            return savedMedications.map { medication in
                ConceptPropertyDTO(
                    rxcui: medication.rxcui,
                    name: medication.name,
                    psn: medication.psn
                )
            }
        }
    
}

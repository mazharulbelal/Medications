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
    func deleteMedication(_ conceptProperty: ConceptPropertyDTO) throws
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
        guard let rxcui = medication.rxcui else {return}
        // Check if the medication already exists
        if realm.object(ofType: ConceptPropertyEntity.self, forPrimaryKey: rxcui) != nil {
            print("Medication with rxcui \(rxcui) already exists in Realm.")
            return
        }

        let entity = ConceptPropertyEntity(from: medication)
        try realm.write {
            realm.add(entity, update: .modified)
        }
        print("Medication saved successfully.")
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
    
    
    func deleteMedication(_ conceptProperty: ConceptPropertyDTO) throws {
        guard let rxcui = conceptProperty.rxcui,
              let entity = realm.objects(ConceptPropertyEntity.self).filter("rxcui == %@", rxcui).first else {
            print("No valid medication to delete.")
            return
        }

        try realm.write {
            realm.delete(entity)
        }
        print("Medication deleted.")
    }


}

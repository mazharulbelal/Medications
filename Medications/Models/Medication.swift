//
//  Medication.swift
//  Medications
//
//  Created by Mazharul on 21/4/25.
//

import Foundation

// MARK: - Medication Model
struct Medication: Codable {
    let drugGroup: DrugGroup?
}

struct DrugGroup: Codable {
    let conceptGroup: [ConceptGroup]?
}

struct ConceptGroup: Codable {
    let conceptProperties: [ConceptProperty]?
}
struct ConceptProperty: Codable, Identifiable {
    var id: String { rxcui ?? UUID().uuidString }
    let rxcui: String?
    let name: String?
    let psn: String?
}

struct MedicationDTO: Decodable {
    let drugGroup: DrugGroupDTO?
}

struct DrugGroupDTO: Decodable {
    let conceptGroup: [ConceptGroupDTO]?
}

struct ConceptGroupDTO: Decodable {
    let conceptProperties: [ConceptPropertyDTO]?
}

struct ConceptPropertyDTO: Decodable, Identifiable {
    var id: String { rxcui ?? UUID().uuidString }
    let rxcui: String?
    let name: String?
    let psn: String?
}



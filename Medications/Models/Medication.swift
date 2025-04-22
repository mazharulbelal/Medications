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
    let synonym: String?
    let umlscui: String?
    let psn: String?
}

extension ConceptProperty {
    static var dummy: ConceptProperty {
        ConceptProperty(
            rxcui: "123456",
            name: "Paracetamol",
            synonym: "Acetaminophen",
            umlscui: "UMLS123",
            psn: "Paracetamol Synonym Name"
        )
    }
}

extension Medication {
    static var dummy: Medication {
        return Medication(
            drugGroup: DrugGroup(
                conceptGroup: [
                    ConceptGroup(conceptProperties: [
                        ConceptProperty(
                            rxcui: "750149",
                            name: "{6 (azithromycin 250 MG Oral Tablet [Zithromax]) } Pack [Z-PAK]",
                            synonym: "Z-PAK",
                            umlscui: "",
                            psn: "Z-PAK 6 Count Pack"
                        ),
                        ConceptProperty(
                            rxcui: "750157",
                            name: "{3 (azithromycin 500 MG Oral Tablet [Zithromax]) } Pack [TRI-PAK]",
                            synonym: "TRI-PAK",
                            umlscui: "",
                            psn: "Zithromax TRI-PAK, 3 Count"
                        )
                    ]),
                    ConceptGroup(conceptProperties: [
                        ConceptProperty(
                            rxcui: "749780",
                            name: "{3 (azithromycin 500 MG Oral Tablet) } Pack",
                            synonym: "azithromycin 500 MG Oral Tablet 3 Count Pack",
                            umlscui: "",
                            psn: "azithromycin 500 MG Oral Tablet 3 Count Pack"
                        ),
                        ConceptProperty(
                            rxcui: "749783",
                            name: "{6 (azithromycin 250 MG Oral Tablet) } Pack",
                            synonym: "azithromycin 250 MG Oral Tablet 6 Count Pack",
                            umlscui: "",
                            psn: "azithromycin 250 MG Oral Tablet 6 Count Pack"
                        )
                    ]),
                    ConceptGroup(conceptProperties: [
                        ConceptProperty(
                            rxcui: "105260",
                            name: "azithromycin 40 MG/ML Oral Suspension [Zithromax]",
                            synonym: "Zithromax 40 MG/ML Oral Suspension",
                            umlscui: "",
                            psn: "Zithromax 200 MG in 5 mL Oral Suspension"
                        ),
                        ConceptProperty(
                            rxcui: "1668240",
                            name: "azithromycin 500 MG Injection [Zithromax]",
                            synonym: "Zithromax 500 MG Injection",
                            umlscui: "",
                            psn: "Zithromax 500 MG Injection"
                        )
                    ]),
                    ConceptGroup(conceptProperties: [
                        ConceptProperty(
                            rxcui: "141962",
                            name: "azithromycin 250 MG Oral Capsule",
                            synonym: "azithromycin (as azithromycin dihydrate) 250 MG Oral Capsule",
                            umlscui: "",
                            psn: "azithromycin 250 MG Oral Capsule"
                        ),
                        ConceptProperty(
                            rxcui: "204844",
                            name: "azithromycin 600 MG Oral Tablet",
                            synonym: nil,
                            umlscui: "",
                            psn: "azithromycin 600 MG Oral Tablet"
                        )
                    ])
                ]
            )
        )
    }
}

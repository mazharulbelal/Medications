//
//  MedicationEntity.swift
//  Medications
//
//  Created by Mazharul on 23/4/25.
//


import RealmSwift
import Foundation

final class MedicationEntity: Object {
    @Persisted var drugGroup: DrugGroupEntity?

    convenience init(from dto: MedicationDTO) {
        self.init()
        if let group = dto.drugGroup {
            self.drugGroup = DrugGroupEntity(from: group)
        }
    }
}

final class DrugGroupEntity: Object {
    @Persisted var conceptGroup = List<ConceptGroupEntity>()

    convenience init(from dto: DrugGroupDTO) {
        self.init()
        if let groups = dto.conceptGroup {
            self.conceptGroup.append(objectsIn: groups.map { ConceptGroupEntity(from: $0) })
        }
    }
}

final class ConceptGroupEntity: Object {
    @Persisted var conceptProperties = List<ConceptPropertyEntity>()

    convenience init(from dto: ConceptGroupDTO) {
        self.init()
        if let props = dto.conceptProperties {
            self.conceptProperties.append(objectsIn: props.map { ConceptPropertyEntity(from: $0) })
        }
    }
}

final class ConceptPropertyEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var rxcui: String?
    @Persisted var name: String?
    @Persisted var synonym: String?
    @Persisted var umlscui: String?
    @Persisted var psn: String?

    convenience init(from dto: ConceptPropertyDTO) {
        self.init()
        self.id = dto.rxcui ?? UUID().uuidString
        self.rxcui = dto.rxcui
        self.name = dto.name
        self.psn = dto.psn
    }
}

//
//  ContactEntity+CoreDataProperties.swift
//  PokemonContacts
//
//  Created by ByonJoonYoung on 4/23/25.
//
//

import Foundation
import CoreData


extension ContactEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactEntity> {
        return NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var imageURL: String?

}

extension ContactEntity : Identifiable {

}

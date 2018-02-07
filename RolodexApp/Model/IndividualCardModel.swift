//
//  IndividualCardModel.swift
//  RolodexApp
//
//  Created by Divya Basappa on 2/6/18.
//  Copyright © 2018 Divya Basappa. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]

public protocol JSONDeserailizable {
    init?(dictionary: JSONDictionary)
}

public struct CardDetails {
   public let induvidualCard: [JSONDictionary]
}

extension CardDetails: JSONDeserailizable {
    public init?(dictionary: JSONDictionary) {
        guard
            let induvidualCard = dictionary["induvidulaCard"] as? [JSONDictionary]
            else {
                return nil
        }
        self.induvidualCard = induvidualCard
    }
}

struct Card: JSONDeserailizable {
    
    let lastName: String
    let firstName: String
    let email: String
    let company: String
    let startDate: String
    let bio: String
    let avatar: String
    
    init?(dictionary: JSONDictionary) {
        guard
            let lastName = dictionary["lastName"] as? String,
            let firstName = dictionary["firstName"] as? String,
            let email = dictionary["email"] as? String,
            let company = dictionary["company"] as? String,
            let startDate = dictionary["startDate"] as? String,
            let bio = dictionary["bio"] as? String,
            let avatar = dictionary["avatar"] as? String
            else {
                return nil
        }
        
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
        self.company = company
        self.startDate = startDate
        self.bio = bio
        self.avatar = avatar
    }
}


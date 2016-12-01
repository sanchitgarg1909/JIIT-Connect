//
//  Enums.swift
//  JIIT Connect
//
//  Created by Sanchit Garg on 30/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

enum Days: String {
    case Monday = "monday"
    case Tuesday = "tuesday"
    case Wednesday = "wednesday"
    case Thursday = "thursday"
    case Friday = "friday"
    case Saturday = "saturday"
}

enum BackendError: Error {
    case objectSerialization(reason: String)
}

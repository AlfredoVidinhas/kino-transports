//
//  RequestModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 03/03/22.
//

import SwiftUI
import Firebase

struct RequestModel{
    var active: Bool?
    var cliente: String?
    var from: GeoPoint?
    var motorista: String?
    var preco: String?
    var tipoCarro: String?
    var to: GeoPoint?
    var fromTitle: String?
    var toTitle: String?
}

//
//  Checklist.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 17/10/2022.
//

import Foundation

class Checklist: NSObject, Codable{
  var name = ""
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
}

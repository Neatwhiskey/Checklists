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
  var iconName = "No Icon"
  
  func countUncheckedItems() -> Int{
    return items.reduce(0){
      count, item in count + (item.checked ? 0:1)
    }
//    var count = 0
//    for item in items where !item.checked{
//      count += 1
//    }
//    return count
  }
  
  func countUncheckedItems() -> Int{
    return items.reduce(0){
      count, item in count + (item.checked ? 0:1)
    }
//    var count = 0
//    for item in items where !item.checked{
//      count += 1
//    }
//    return count
  }
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
}

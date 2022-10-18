//
//  DataModel.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 19/10/2022.
//

import Foundation
class DataModel{
  var lists = [Checklist]()
  
    //MARK: - Data saving
  
  init(){
    loadChecklists()
  }
  
  func documentsDirectory()->URL{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func dataFile()->URL{
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func saveChecklists(){
    let encoder = PropertyListEncoder()
    do{
      let data = try encoder.encode(lists)
      try data.write(to: dataFile(), options: Data.WritingOptions.atomic)
    }catch{
      print("error encoding list array: \(error.localizedDescription)")
    }
  }
  
  func loadChecklists(){
    let path = dataFile()
    if let data = try? Data(contentsOf: path){
      let decoder = PropertyListDecoder()
      do{
        lists = try decoder.decode([Checklist].self, from: data)
      }catch{
        print("error decoding list array: \(error.localizedDescription)")
      }
    }
    
  }
}

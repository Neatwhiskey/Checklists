  //
  //  ChecklistViewController.swift
  //  Checklists
  //
  //  Created by Jamaaldeen Opasina on 14/10/2022.
  //

import UIKit

class ChecklistViewController: UITableViewController{
  var items = [ChecklistItem]()
  var checklist: Checklist!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = checklist.name
    navigationController?.navigationBar.prefersLargeTitles = false

    //loadChecklistItems()
  }

  // MARK: - Navigation
  override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?
  ) {
    if segue.identifier == "AddItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self

      if let indexPath = tableView.indexPath(
        for: sender as! UITableViewCell) {
        controller.itemToEdit = checklist.items[indexPath.row]
      }
    }
  }

  // MARK: - Table View Data Source
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return checklist.items.count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChecklistItem",
      for: indexPath)

    let item = checklist.items[indexPath.row]

    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)

    return cell
  }
}

  // MARK: - Table View Delegate
extension ChecklistViewController{
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = checklist.items[indexPath.row]
      item.checked.toggle()
      
      configureCheckmark(for: cell, with: item)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
    //saveChecklistItems()
  }
  
  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    checklist.items.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    //saveChecklistItems()
  }

}
  // MARK: - Actions
extension ChecklistViewController{
  func configureCheckmark(
    for cell: UITableViewCell,
    with item: ChecklistItem
  ) {
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }
  
  func configureText(
    for cell: UITableViewCell,
    with item: ChecklistItem
  ) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask)
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
//  func saveChecklistItems() {
//    let encoder = PropertyListEncoder()
//    do {
//      let data = try encoder.encode(items)
//      try data.write(
//        to: dataFilePath(),
//        options: Data.WritingOptions.atomic)
//    } catch {
//      print("Error encoding item array: \(error.localizedDescription)")
//    }
//  }
//
//  func loadChecklistItems() {
//    let path = dataFilePath()
//    if let data = try? Data(contentsOf: path) {
//      let decoder = PropertyListDecoder()
//      do {
//        items = try decoder.decode(
//          [ChecklistItem].self,
//          from: data)
//      } catch {
//        print("Error decoding item array: \(error.localizedDescription)")
//      }
//    }
//  }

}

  // MARK: - Add Item ViewController Delegates
extension ChecklistViewController: ItemDetailViewControllerDelegate{
  func ItemDetailViewControllerDidCancel(
    _ controller: ItemDetailViewController
  ) {
    navigationController?.popViewController(animated: true)
  }
  
  func ItemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  ) {
    let newRowIndex = checklist.items.count
    checklist.items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated:true)
    checklist.sortChecklistItem()
    //saveChecklistItems()
  }
  
  func ItemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem
  ) {
    if let index = checklist.items.firstIndex(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    checklist.sortChecklistItem()
    navigationController?.popViewController(animated: true)
    //saveChecklistItems()
  }
}

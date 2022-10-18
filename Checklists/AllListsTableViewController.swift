//
//  AllListTableViewController.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 17/10/2022.
//

import UIKit

class AllListsTableViewController: UITableViewController {
  var cellIdentifier = "CheckistCell"
  var lists = [Checklist]()
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      
      var list = Checklist(name: "Birthdays")
      lists.append(list)
      
      list = Checklist(name: "Groceries")
      lists.append(list)
      
      list = Checklist(name: "Cool apps")
      lists.append(list)
      
      list = Checklist(name: "To-Do")
      lists.append(list)
      
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // Configure the cell...
      let checklists = lists[indexPath.row]
      cell.textLabel?.text = checklists.name
      cell.accessoryType = .detailDisclosureButton

        return cell
    }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let checklist = lists[indexPath.row]
    performSegue(withIdentifier: "showChecklist", sender: checklist)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    lists.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
    controller.delegate = self
    let checklist = lists[indexPath.row]
    controller.checklistToEdit = checklist
    navigationController?.pushViewController(controller, animated: true)
  }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
      if segue.identifier == "showChecklist"{
        let controller = segue.destination as! ChecklistViewController
        controller.checklist = sender as? Checklist
      }else if segue.identifier == "AddChecklist"{
        let controller = segue.destination as! ListDetailViewController
        controller.delegate = self
      }
        // Pass the selected object to the new view controller.
    }

}

extension AllListsTableViewController: ListDetailViewControllerDelegate{
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding item: Checklist) {
    let newRowIndex = lists.count
    lists.append(item)
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated: true)
    
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing item: Checklist) {
    if let index = lists.firstIndex(of: item){
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath){
        cell.textLabel!.text = item.name
      }
    }
    navigationController?.popViewController(animated: true)
  }
  
  
}

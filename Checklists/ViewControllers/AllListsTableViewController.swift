//
//  AllListTableViewController.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 17/10/2022.
//

import UIKit

class AllListsTableViewController: UITableViewController {
  var cellIdentifier = "CheckistCell"
  var dataModel: DataModel!
  //MARK: - view controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
      //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      

    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.delegate = self
    let index = dataModel.indexOfSelectedChecklist
    if index >= 0 && index < dataModel.indexOfSelectedChecklist{
      let chcklist = dataModel.lists[index]
      performSegue(withIdentifier: "showChecklist", sender: chcklist)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: UITableViewCell
      if let tmp = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
        cell = tmp
      }else{
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
      }
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // Configure the cell...
      let checklist = dataModel.lists[indexPath.row]
      let count = checklist.countUncheckedItems()
      cell.textLabel!.text = checklist.name
      if checklist.items.count == 0{
        cell.detailTextLabel!.text = "(No items)"
      }else{
        cell.detailTextLabel!.text = count == 0 ? "All done": "\(checklist.countUncheckedItems()) remaining"
      }
      cell.accessoryType = .detailDisclosureButton

        return cell
    }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let checklist = dataModel.lists[indexPath.row]
    performSegue(withIdentifier: "showChecklist", sender: checklist)
    dataModel.indexOfSelectedChecklist = indexPath.row
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
    controller.delegate = self
    let checklist = dataModel.lists[indexPath.row]
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
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
    //let newRowIndex = dataModel.lists.count
    dataModel.lists.append(checklist)
    dataModel.sortChecklist()
    tableView.reloadData()
//    let indexPath = IndexPath(row: newRowIndex, section: 0)
//    let indexPaths = [indexPath]
//    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated: true)
    
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing item: Checklist) {
//    if let index = dataModel.lists.firstIndex(of: item){
//      let indexPath = IndexPath(row: index, section: 0)
//      if let cell = tableView.cellForRow(at: indexPath){
//        cell.textLabel!.text = item.name
//      }
//    }
    dataModel.sortChecklist()
    tableView.reloadData()
    navigationController?.popViewController(animated: true)
  }
  
  
}

extension AllListsTableViewController:UINavigationControllerDelegate{
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    if viewController === self{
      dataModel.indexOfSelectedChecklist = -1
      
    }
  }
}

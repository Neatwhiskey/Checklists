//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 18/10/2022.
//

import UIKit

class ListDetailViewController: UITableViewController {
//MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      if let checklist = checklistToEdit{
        title = "Edit checklist"
        textField.text = checklist.name
        iconName = checklist.iconName
        doneBarButton.isEnabled = true
      }
      iconImage.image = UIImage(named: iconName)
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  //MARK: - IBOutlets
  @IBOutlet var textField: UITextField!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var doneBarButton: UIBarButtonItem!
  
  //MARK: IBActions
    @IBAction func cancel(){
      delegate?.listDetailViewControllerDidCancel(self)
    }
  @IBAction func done(){
    if let checklist = checklistToEdit{
      checklist.name = textField.text!
      checklist.iconName = iconName
      delegate?.listDetailViewController(self, didFinishEditing: checklist)
    }else{
      let checklist = Checklist(name: textField.text!, iconName: iconName)
      checklist.iconName = iconName
      checklist.name = textField.text!
      delegate?.listDetailViewController(self, didFinishAdding: checklist)
    }
  }
  
  //MARK: - variables
  weak var delegate: ListDetailViewControllerDelegate?
  var checklistToEdit: Checklist?
  var iconName = "Folder"

  
    // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PickIcon"{
      let controller = segue.destination as! IconPickerViewController
      controller.delegate = self
      
    }
  }

    

}

//MARK: - TextFieldDelegates
extension ListDetailViewController: UITextFieldDelegate{
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath.section == 1 ? indexPath:nil
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    doneBarButton.isEnabled = !newText.isEmpty
    
    return true
  }
  
//  func textFieldShouldClear(_ textField: UITextField) -> Bool {
//    doneBarButton.isEnabled = false
//    return true
//  }
}

//MARK: - IconPickerViewControllerDelegate
extension ListDetailViewController: IconPickerViewControllerDelegate{
  func IconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
    self.iconName = iconName
    iconImage.image = UIImage(named: iconName)
    navigationController?.popViewController(animated: true)
  }
  
  
}

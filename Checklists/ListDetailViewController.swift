//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 18/10/2022.
//


class ListDetailViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let checklist = checklistToEdit{
      title = "Edit checklist"
import UIKit
        textField.text = checklist.name
        doneBarButton.isEnabled = true
      }
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  //MARK: - IBOutlets
  @IBOutlet var textField: UITextField!
  @IBOutlet var doneBarButton: UIBarButtonItem!
  
  //MARK: IBActions
    @IBAction func cancel(){
      delegate?.listDetailViewControllerDidCancel(self)
    }
  @IBAction func done(){
    if let checklist = checklistToEdit{
      checklist.name = textField.text!
      delegate?.listDetailViewController(self, didFinishEditing: checklist)
    }else{
      let checklist = Checklist(name: textField.text!)
      delegate?.listDetailViewController(self, didFinishAdding: checklist)
    }
  }
  
  //MARK: - variables
  weak var delegate: ListDetailViewControllerDelegate?
  var checklistToEdit: Checklist?

  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Delegates
extension ListDetailViewController: UITextFieldDelegate{
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    doneBarButton.isEnabled = !newText.isEmpty
    
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneBarButton.isEnabled = false
    return true
  }
}

//
//  protocols.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 16/10/2022.
//

import Foundation
//MARK: - ItemDetailViewControllerDelegate
protocol ItemDetailViewControllerDelegate: AnyObject {
  func ItemDetailViewControllerDidCancel(
    _ controller: ItemDetailViewController)
  func ItemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  )
  func ItemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem
  )
}

//MARK: - ListDetailViewControllerDelegate
protocol ListDetailViewControllerDelegate: AnyObject{
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding item: Checklist)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing item: Checklist)
}

//MARK: - IconPickerDelegate
protocol IconPickerViewControllerDelegate: AnyObject{
  func IconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

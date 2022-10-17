//
//  protocols.swift
//  Checklists
//
//  Created by Jamaaldeen Opasina on 16/10/2022.
//

import Foundation
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

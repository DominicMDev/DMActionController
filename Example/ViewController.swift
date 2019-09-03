//
//  ViewController.swift
//  Example
//
//  Created by Dominic Miller on 9/2/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

import DMActionController

class ViewController: UIViewController {
    
    var numberOfActions: Int = 5
    var shouldShowTitle = true
    var shouldShowMessage = true
    var shouldShowCancelButton = true
    var shouldShowImages = true
    var shouldTapBackgroundToDismiss = true
    var shouldDragViewToDismiss = true
    
    @IBOutlet weak var collectionButton: UIButton!
    
    @IBOutlet weak var numberOfActionsLabel: UILabel!
    
    @IBAction func didChangeNumberOfActions(_ sender: UISlider) {
        numberOfActions = Int(sender.value.rounded())
        numberOfActionsLabel.text = "\(numberOfActions)"
    }
    
    @IBAction func didChangeCancel(_ sender: UISwitch) {
        shouldShowCancelButton = sender.isOn
    }
    
    @IBAction func didChangeImages(_ sender: UISwitch) {
        shouldShowImages = sender.isOn
    }
    
    @IBAction func didChangeTitle(_ sender: UISwitch) {
        shouldShowTitle = sender.isOn
    }
    
    @IBAction func didChangeMessage(_ sender: UISwitch) {
        shouldShowMessage = sender.isOn
    }
    
    @IBAction func didChangeBackground(_ sender: UISwitch) {
        shouldTapBackgroundToDismiss = sender.isOn
    }
    
    @IBAction func didChangeDrag(_ sender: UISwitch) {
        shouldDragViewToDismiss = sender.isOn
    }
    
    @IBAction func didPressTable() {
        let title = shouldShowTitle ? "Action Sheet" : nil
        let message = shouldShowMessage ? "Select an action" : nil
        let table = DMActionController(title: title,
                                       message: message,
                                       preferredStyle: .table)
        addActions(to: table)
        table.tapBackgroundToDismiss = shouldTapBackgroundToDismiss
        table.canDragToDismiss = shouldDragViewToDismiss
        present(table, animated: true, completion: nil)
    }
    
    @IBAction func didPressCollection() {
        let title = shouldShowTitle ? "Action Sheet" : nil
        let message = shouldShowMessage ? "Select an action" : nil
        let collection = DMActionController(title: title,
                                            message: message,
                                            preferredStyle: .collection)
        addActions(to: collection)
        collection.tapBackgroundToDismiss = shouldTapBackgroundToDismiss
        collection.canDragToDismiss = shouldDragViewToDismiss
        present(collection, animated: true, completion: nil)
    }
    
    private func addActions(to sheet: DMActionController) {
        for i in 1...numberOfActions {
            let image = shouldShowImages ? UIImage(named: "icon-\(i)", in: Bundle(for: ViewController.self), compatibleWith: nil) : nil
            sheet.addAction(DMAction(image: image, title: "Action \(i)", style: .default))
        }
        if shouldShowCancelButton {
            sheet.addAction(DMAction(title: "Cancel", style: .cancel))
        }
    }
    
}


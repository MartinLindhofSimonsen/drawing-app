//
//  ViewController.swift
//  iDoodle
//
//  Created by Martin Lindhof Simonsen on 05/04/2017.
//  Copyright © 2017 Martin Lindhof Simonsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var doodleView: DoodleView!

    @IBAction func undoButton(_ sender: UIBarButtonItem) {
        doodleView.undo()
    }

    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        displayEraseDialog()
    }
    
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        let itemToShare = ["Check det ud mand!, mit fantastiske Doodle", doodleView.image] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            displayEraseDialog()
        }
    }
    
    func displayEraseDialog() {
        let alertController = UIAlertController(
            title: "Slet",
            message: "Er du sikker på du vil slette?",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(
            title: "Annuler",
            style: .cancel,
            handler: nil)
        
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(
            title: "Slet",
            style: .default,
            handler: {(action) in self.doodleView.clear()})
        
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion:  nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "color" {
            let destinationViewController = (segue.destination as! UINavigationController).viewControllers.first as! ColorViewController
            destinationViewController.delegate = self
            destinationViewController.color = doodleView.drawingColor
        } else if segue.identifier == "stroke" {
            let destinationViewController = (segue.destination as! UINavigationController).viewControllers.first as! StrokeViewController
            destinationViewController.delegate = self
            destinationViewController.strokeWidth = doodleView.strokeWidth
            destinationViewController.color = doodleView.drawingColor
        }
    }
    
    @IBAction func RewindToDoodleViewController(segue: UIStoryboardSegue) {}
}

extension ViewController: ColorViewControllerDelegate, StrokeViewControllerDelegate {
    func colorChanged(_ color: UIColor) {
        doodleView.drawingColor = color
    }
    
    func strokeChanged(_ strokeWidth: CGFloat) {
        doodleView.strokeWidth = strokeWidth
    }
}


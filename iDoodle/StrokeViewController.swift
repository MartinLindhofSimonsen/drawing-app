//
//  StrokeViewController.swift
//  iDoodle
//
//  Created by Martin Lindhof Simonsen on 05/04/2017.
//  Copyright © 2017 Martin Lindhof Simonsen. All rights reserved.
//

import UIKit

protocol StrokeViewControllerDelegate {
    func strokeChanged(_ strokeWidth: CGFloat)
}

class StrokeViewController: UIViewController {

    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var strokeView: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    var color: UIColor = UIColor.black
    var strokeWidth: CGFloat = 10.0
    var delegate: StrokeViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        widthSlider.value = Float(strokeWidth)
        strokeView.backgroundColor = color
        height.constant = strokeWidth
    }
    
    @IBAction func strokeChanged(_ sender: UISlider) {
        strokeWidth = CGFloat(widthSlider.value)
        height.constant = strokeWidth
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIBarButtonItem)?.tag == 1 {
            self.delegate?.strokeChanged(self.strokeWidth)
        }
    }
}

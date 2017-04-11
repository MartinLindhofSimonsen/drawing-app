//
//  ColorViewController.swift
//  iDoodle
//
//  Created by Martin Lindhof Simonsen on 05/04/2017.
//  Copyright © 2017 Martin Lindhof Simonsen. All rights reserved.
//

import UIKit

protocol ColorViewControllerDelegate {
    func colorChanged(_ color: UIColor)
}

class ColorViewController: UIViewController {

    @IBOutlet weak var alpha: UISlider!
    @IBOutlet weak var red: UISlider!
    @IBOutlet weak var green: UISlider!
    @IBOutlet weak var blue: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    var color = UIColor.black
    var delegate: ColorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var colorRed: CGFloat = 0.0
        var colorGreen: CGFloat = 0.0
        var colorBlue: CGFloat = 0.0
        var colorAlpha: CGFloat = 1.0
        
        color.getRed(&colorRed, green: &colorGreen, blue: &colorBlue, alpha: &colorAlpha)
        red.value = Float(colorRed)
        green.value = Float(colorGreen)
        blue.value = Float(colorBlue)
        alpha.value = Float(colorAlpha)
        colorView.backgroundColor = color
    }

    @IBAction func colorChanged(_ sender: UISlider) {
        colorView.backgroundColor = UIColor(
            red: CGFloat(red.value),
            green: CGFloat(green.value),
            blue: CGFloat(blue.value),
            alpha: CGFloat(alpha.value))
        
        color = colorView.backgroundColor!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIBarButtonItem)?.tag == 1 {
            self.delegate?.colorChanged(self.color)
        }
    }
}

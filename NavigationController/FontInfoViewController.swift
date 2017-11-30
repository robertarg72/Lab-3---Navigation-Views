/*
 * FontInfoViewController.swift
 * Project: Lab 3 - Navigation Views
 * Students:
 *              Ling Bao        300901785
 *              Robert Argume   300949529
 * Date: Nov 29, 2017
 * Description: Hierarchical Navigation views using tables to show System Fonts.
 *              It shows samples with different sizes for a selected font.
 *              It also allows to select some fonts as Favourite Fonts.
 * Version: 0.1
 * Notes: Added contraints to render slider and switch views properly in landscap mode
 */

import UIKit

class FontInfoViewController: UIViewController {
    // Variables for this class
    var font: UIFont!
    var favourite: Bool = false
    
    // Outlets to manage controls in the view
    @IBOutlet weak var fontSampleLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var favouriteSwitch: UISwitch!
    
    // Overriden function for the UIViewController protocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSampleLabel.font = font
        fontSampleLabel.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789"
        fontSizeSlider.value = Float(font.pointSize)
        fontSizeLabel.text = "\(Int(font.pointSize))"
        favouriteSwitch.isOn = favourite
    }

    // Actions to manage slider and switch views
    
    @IBAction func slideFontSize(slider: UISlider) {
        let newSize = roundf(slider.value)
        fontSampleLabel.font = font.withSize(CGFloat(newSize))
        fontSizeLabel.text = "\(Int(newSize))"
    }
  
    @IBAction func toogleFavourite(sender: UISwitch) {
        let favouritesList = FavouritesList.sharedFavouritesList
        if sender.isOn {
            favouritesList.addFavourite(fontName: font.fontName)
        } else {
            favouritesList.removeFavourite(fontName: font.fontName)
        }
    }
}

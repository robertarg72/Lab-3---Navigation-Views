/*
 * FontSizesViewController.swift
 * Project: Lab 3 - Navigation Views
 * Students:
 *              Ling Bao        300901785
 *              Robert Argume   300949529
 * Date: Nov 29, 2017
 * Description: Hierarchical Navigation views using tables to show System Fonts.
 *              It shows samples with different sizes for a selected font.
 *              It also allows to select some fonts as Favourite Fonts.
 * Version: 0.1
 */

import UIKit

class FontSizesViewController: UITableViewController {
    // Variables for this class
    var font:UIFont!
    private static let pointSizes: [CGFloat] = [
        9,10,11,12,13,14,18,24,36,48,64,72,96,144
    ]
    private static let cellIdentifier = "FontNameAndSize"
    
    // Overriden function for UITableViewController protocol
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = FontSizesViewController.pointSizes[0]
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FontSizesViewController.pointSizes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FontSizesViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        cell.textLabel?.text = font.fontName
        cell.detailTextLabel?.text = "\(FontSizesViewController.pointSizes[indexPath.row]) point"
        return cell
        
    }
  
    // Utility functions
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let pointSize = FontSizesViewController.pointSizes[indexPath.row]
        return font.withSize(pointSize)
    }

}

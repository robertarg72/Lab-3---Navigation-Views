/*
 * FontListViewController.swift
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

class FontListViewController: UITableViewController {
    // Variables for the class
    var fontNames: [String] = []
    var showsFavourites: Bool = false
    private var cellPointSize: CGFloat!
    private static let cellIdentifier = "FontName"
    
    // Overriden methods for UITableViewController protocol
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        
        // Allow Edit button to appear in the top right of the table
        if showsFavourites {
            navigationItem.rightBarButtonItem = editButtonItem
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavourites {
            fontNames = FavouritesList.sharedFavouritesList.favourites
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        return cell
        
    }
    
    // To reorder cells in the favorite fonts list
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        FavouritesList.sharedFavouritesList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavouritesList.sharedFavouritesList.favourites
    }

    // Segue connection preparation function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizeVC = segue.destination as! FontSizesViewController
            sizeVC.title = font.fontName
            sizeVC.font = font
        } else {
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.title = font.fontName
            infoVC.font = font
            infoVC.favourite = FavouritesList.sharedFavouritesList.favourites.contains(font.fontName)
        }
    }
    
    // Utility function
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name:fontName, size:cellPointSize)!
    }

}

/*
 * RootViewController.swift
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

class RootViewController: UITableViewController {
    // Private variables
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favouritesList: FavouritesList!
    private static let familyCell = "FamilyName"
    private static let favouritesCell = "Favourites"
    
    // Overriden methods for UITableViewController protocol
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = (UIFont.familyNames as [String]).sorted()
        let  preferredTableViewFont =  UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        favouritesList = FavouritesList.sharedFavouritesList
        tableView.estimatedRowHeight = cellPointSize
    }
    
    //Datasource methods for table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return favouritesList.favourites.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favourite Fonts"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RootViewController.familyCell, for: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: RootViewController.favouritesCell, for: indexPath)
        }
    }
    
    // Segue connection method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let listVC = segue.destination as! FontListViewController
        
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            listVC.fontNames = (UIFont.fontNames(forFamilyName: familyName) as [String]).sorted()
            listVC.navigationItem.title = familyName
            listVC.showsFavourites = false
        }
        else {
            listVC.fontNames = favouritesList.favourites
            listVC.navigationItem.title = "Favourites"
            listVC.showsFavourites = true
        }
    }
    
    // Utility method
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            return fontName != nil ? UIFont(name: fontName!, size: cellPointSize) : nil
        } else {
            return nil
        }
    }
      
}

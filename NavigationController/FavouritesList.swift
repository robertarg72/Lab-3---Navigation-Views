/*
 * FavouritesList.swift
 * Project: Lab 3 - Navigation Views
 * Students:
 *              Ling Bao        300901785
 *              Robert Argume   300949529
 * Date: Nov 29, 2017
 * Description: Hierarchical Navigation views using tables to show System Fonts.
 *              It shows samples with different sizes for a selected font.
 *              It also allows to select and save some fonts as Favourite in the users preference file.
 * Version: 0.1
 */

import Foundation
import UIKit

class FavouritesList {
    static let sharedFavouritesList = FavouritesList()
    private(set) var favourites:[String]
    
    init(){
        let defaults = UserDefaults.standard
        let storedFavourites = defaults.object(forKey: "favourites") as? [String]
        favourites = storedFavourites != nil ? storedFavourites! : []
    }
    
    // This method adds a new font to the user preferences file
    func addFavourite(fontName: String) {
        if !favourites.contains(fontName) {
            favourites.append(fontName)
            saveFavourites()
        }
    }
    
    // This method removes a specific font from the user preferences file
    func removeFavourite(fontName: String) {
        if let index = favourites.index(of: fontName) {
            favourites.remove(at: index)
            saveFavourites()
        }
    }
    
    // This method let reorder favourites fonts
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item = favourites[from]
        favourites.remove(at: from)
        favourites.insert(item, at: to)
        saveFavourites()
    }
    
    // This method saves font favourites to the user preferences file
    private func saveFavourites() {
        let defaults = UserDefaults.standard
        defaults.set(favourites, forKey: "favourites")
        defaults.synchronize()
    }
    
}

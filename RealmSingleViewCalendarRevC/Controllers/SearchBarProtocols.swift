//
//  SearchBarProtocols.swift
//  RealmSingleViewCalendarRevC
//
//  Created by Drew Collier on 8/3/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//

import UIKit


extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        filterContentForSearchText(text)
    }

    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
      filterContentForSearchText(searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {
        //filteredEvents = eventStoreService.eventsList.filter { (event: EKEvent) -> Bool in
            //return event.title.lowercased().contains(searchText.lowercased())
    //}
      
      //print(filteredEvents)
    }
}


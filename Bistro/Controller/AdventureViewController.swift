//
//  AdventureViewController.swift
//  Bistro
//
//  Created by Joshua  Lee on 3/21/18.
//  Copyright © 2018 Joshua  Lee. All rights reserved.
//

import UIKit

class AdventureViewController: UIViewController {

    @IBOutlet weak var adventureTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.adventureTableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    // REQUIRED METHODS
    
    
    
    func configureTableView() {
        adventureTableView.rowHeight = UITableViewAutomaticDimension
        adventureTableView.estimatedRowHeight = 100.0
    }
    
}

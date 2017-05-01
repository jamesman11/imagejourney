//
//  HomefeedViewController.swift
//  imagejourney
//
//  Created by Sophia on 4/29/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit

class HomefeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var journals: [Journal]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // table view defaults
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 380

        
        // Fetch journals to show
        ParseClient.sharedInstance.getJournalsWithCompletion(completion: { (journals: [Journal]?) in
            if journals != nil {
                self.journals = journals
                self.tableView.reloadData()
            } else {
                print("journals fetch failed")
            }
        })
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell") as! JournalCell
        let journal = journals?[indexPath.row]
        cell.buildCellWithJournal(journal: journal!)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (journals?.count)!
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homefeedToJournalSegue" {
            let journalViewController = segue.destination as! JournalViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            journalViewController.journal = journals?[indexPath!.row]
        }
    }
}

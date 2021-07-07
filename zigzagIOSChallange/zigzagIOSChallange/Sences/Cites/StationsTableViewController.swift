//
//  CitesTableViewController.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/7/21.
//

import UIKit

class StationsTableViewController: UITableViewController {
var StationList = [Station]()
    var selectedStationIndex = 0
    var badCannstattStation = Station()
    var uffKirchhofStation = Station()

    override func viewDidLoad() {
        super.viewDidLoad()

        badCannstattStation.StationName = "Bad Cannstatt"
        badCannstattStation.Stationlatitude = 48.80128
        badCannstattStation.Stationlongitude = 9.21747
        badCannstattStation.StopPointRef = "de:08111:6333"
        badCannstattStation.ImageName = "transportationStop"
        StationList.append(badCannstattStation)
        
        uffKirchhofStation.StationName = "Uff-Kirchhof"
        uffKirchhofStation.Stationlatitude = 48.80500
        uffKirchhofStation.Stationlongitude = 9.22588
        uffKirchhofStation.StopPointRef = "de:08111:32"
        uffKirchhofStation.ImageName = "transportationUBahn"
        StationList.append(uffKirchhofStation)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStationIndex = indexPath.row
        performSegue(withIdentifier: "LinesDetailsNav", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is LinesDetailsViewController {
            let vc = segue.destination as? LinesDetailsViewController
            vc?.station = StationList[selectedStationIndex]
        }
    }
}

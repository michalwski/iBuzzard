//
//  HistoryTableViewController.swift
//  iBuzzard
//
//  Created by Krzysztof Profic on 26.08.2016.
//  Copyright © 2016 Trifork GmbH. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    var history: [[NSDate:NSTimeInterval]] = [[NSDate(): 5]]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

//        let s: String = try! String(contentsOfURL: NSURL(string: "http://10.152.1.42:9000/motion_vod")!)
//        print("s \(s)")
//        VODLister().list()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = history[indexPath.item].description
        return cell
    }
}
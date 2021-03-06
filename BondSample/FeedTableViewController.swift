//
//  FeedTableViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/27.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond
import SafariServices

class FeedTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let feedViewModel = FeedTableViewModel()
    var dataSource = ObservableArray<ObservableArray<Feed>>()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ObservableArray([feedViewModel.items])
        
        dataSource.bindTo(tableView) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedTableCell
            let feed:Feed = dataSource[indexPath.section][indexPath.row]
            feed.title
                .bindTo(cell.title.bnd_text)
                .disposeIn(cell.bnd_bag)
            feed.username
                .map{ "@" + $0! }
                .bindTo(cell.username.bnd_text)
                .disposeIn(cell.bnd_bag)
            feed.userImage
                .bindTo(cell.userImageView.bnd_image)
                .disposeIn(cell.bnd_bag)
            
            feed.fetchImageIfNeeded()
            return cell
        }
        
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.feedViewModel.request()
    }
    
}

extension FeedTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let feed:Feed = dataSource[indexPath.section][indexPath.row]
        if let url = feed.url {
            let safariVC = SFSafariViewController(URL: url)
            self.navigationController?.showViewController(safariVC, sender: nil)
        }
    }
}

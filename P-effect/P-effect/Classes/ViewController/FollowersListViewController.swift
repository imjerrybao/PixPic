//
//  FollowersViewController.swift
//  P-effect
//
//  Created by anna on 3/3/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

final class FollowersListViewController: UIViewController, StoryboardInitable {
    
    static let storyboardName = Constants.Storyboard.Profile

    var router: protocol<ProfilePresenter, AlertManagerDelegate>!
    
    //TODO: replace "var user: User!" to "var followers: [User]"
    var user: User!
    var followType: FollowType!
    
    private lazy var followerAdapter = FollowerAdapter()
    private weak var locator: ServiceLocator!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigavionBar()
        setupAdapter()
    }
    
    func setLocator(locator: ServiceLocator) {
        self.locator = locator
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.registerNib(FollowerViewCell.cellNib, forCellReuseIdentifier: FollowerViewCell.identifier)
    }
    
    private func setupNavigavionBar() {
        navigationItem.title = followType.rawValue
    }
    
    private func setupAdapter() {
        tableView.dataSource = followerAdapter
    }
    
}

extension FollowersListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let follower = followerAdapter.getFollower(atIndexPath: indexPath)
        router.showProfile(follower)
    }
    
}

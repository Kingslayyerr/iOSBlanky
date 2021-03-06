//
//  ViewController.swift
//  iOSBlanky
//
//  Created by Levi Bostian on 5/3/16.
//  Copyright © 2016 Curiosity IO. All rights reserved.
//

import UIKit
import SwiftOverlays
import Kamagari
import iOSViews

class MainViewController: BaseUIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    private var gitHubController: GitHubController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gitHubController = GitHubController.getInstance()
        
        setupViews()
    }
    
    private func setupViews() {
        addTextField(usernameTextField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func howManyReposButtonPressed(sender: UIButton) {
        if let gitHubUsername = usernameTextField.text {
            SwiftOverlays.showBlockingWaitOverlayWithText("Getting repos...")
            
            gitHubController.getUserRepos(gitHubUsername: gitHubUsername, onError: { (message) in
                SwiftOverlays.removeAllBlockingOverlays()
                
                AlertBuilder(title: "Error", message: message, preferredStyle: .alert)
                    .addAction(title: "Ok", style: .cancel) { _ in }
                    .build()
                    .kam_show(animated: true)
            }) { (data) in
                SwiftOverlays.removeAllBlockingOverlays()
                
                if let repos = data {
                    AlertBuilder(title: "Success!", message: String(format: "The number of repos for %@ is: %i", gitHubUsername, repos.count), preferredStyle: .alert)
                        .addAction(title: "Cool", style: .cancel) { _ in }
                        .build()
                        .kam_show(animated: true)
                }
            }
        }
    }
    
}

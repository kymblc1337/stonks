//
//  HeaderViewController.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 06.10.2020.
//

import UIKit



class HeaderViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()

    }
}


extension HeaderViewController
{
    func configureUi(){
        self.headerView.layer.cornerRadius = 20
        self.headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        self.headerView.layer.shadowRadius = 20
        self.headerView.layer.shadowOffset = .zero
        self.headerView.layer.shadowOpacity = 0.8
        self.profileImage.image = UIImage(named: "ZUEV")
        self.profileImage.layer.cornerRadius = 15
        
    }
}

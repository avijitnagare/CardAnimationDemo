//
//  ViewController.swift
//  Cred.Com
//
//  Created by IMAC-0025 on 09/01/20.
//  Copyright © 2020 IMAC-0025. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Declare property for table view
    @IBOutlet weak var creditCardsListTableView: UITableView!
    
    //View Model for Card data
    var cardModel = CardsViewModel()
    
    //View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //initial setup
        initialiseViewControllerStuff()
        // Do any additional setup after loading the view.
    }

    //MART:- Private Method
    func initialiseViewControllerStuff() {
       // Navigation Set up
        setupNavBar()
       //Hey TableView i will help you with data
       self.creditCardsListTableView.dataSource = self
       self.creditCardsListTableView.delegate = self
       //Relaod and animate for Brownie once
       self.creditCardsListTableView.reloadData { [weak self] in
        //Get first Cell
           let oneTimeAnimationCell =  self?.creditCardsListTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CustomCardsTableViewCell
            UIView.animate(withDuration: 0.6, animations: {
                oneTimeAnimationCell.cardImageView.transform = CGAffineTransform(translationX: -oneTimeAnimationCell.cardImageView.frame.width/2 , y: 0)
                oneTimeAnimationCell.cardOptionsContentView.transform =  CGAffineTransform(translationX: oneTimeAnimationCell.cardOptionsContentView.frame.width/2 , y: 0)
            }) { (true) in
                UIView.animate(withDuration: 0.6, animations: {
                    oneTimeAnimationCell.cardImageView.transform = CGAffineTransform(translationX: oneTimeAnimationCell.cardImageView.frame.width/2 , y: 0)
                    oneTimeAnimationCell.cardOptionsContentView.transform =  CGAffineTransform(translationX: -oneTimeAnimationCell.cardOptionsContentView.frame.width/2 , y: 0)
                }) { (true) in
                    self?.moveToOriginalPosition(cell: oneTimeAnimationCell)
                }
            }
        }
    }
    
    
    
    
    func setupNavBar() {
        //Screen Title
        self.title = "Cards"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //Add New Card button
        let rightNavButtonForAddNewCard = UIButton(type: .custom)
        rightNavButtonForAddNewCard.setTitle("+Add New", for: .normal)
        rightNavButtonForAddNewCard.setTitleColor(getAppTintColor(), for: .normal)
        rightNavButtonForAddNewCard.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightNavButtonForAddNewCard.backgroundColor = #colorLiteral(red: 0.1090913936, green: 0.1288402081, blue: 0.1620890796, alpha: 1)
        rightNavButtonForAddNewCard.layer.cornerRadius = 10
        rightNavButtonForAddNewCard.layer.masksToBounds = true
        rightNavButtonForAddNewCard.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        navigationController?.navigationBar.addSubview(rightNavButtonForAddNewCard)
        rightNavButtonForAddNewCard.frame = CGRect(x: self.view.frame.width, y: 0, width: 100, height: 40)
        let targetView = self.navigationController?.navigationBar
        let trailingContraint = NSLayoutConstraint(item: rightNavButtonForAddNewCard, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -30)
        let bottomConstraint = NSLayoutConstraint(item: rightNavButtonForAddNewCard, attribute: .bottom, relatedBy: .equal,
                                        toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -6)
        rightNavButtonForAddNewCard.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rightNavButtonForAddNewCard.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rightNavButtonForAddNewCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
   @objc func rightButtonTapped(button: UIButton) {
        alert(title: "Alert!!", message: "Adding New Card")
    }
    
    @IBAction func payNowCardButtonTargetAction(_ sender: UIButton ) {
        alert(title: "Alert!", message: "Paying at index: \(sender.tag)")
    }
    
    @IBAction func viewCardDetailsButtonTargetAction(_ sender: UIButton ) {
        alert(title: "Alert!", message: "Viewing card details at index: \(sender.tag)")
    }
    
}


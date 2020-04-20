//
//  CustomCardsTableViewCell.swift
//  Cred.Com
//
//  Created by IMAC-0025 on 09/01/20.
//  Copyright © 2020 IMAC-0025. All rights reserved.
//

import UIKit

enum SwipeDirection{
    case left
    case right
}

protocol SwipGestureProtocol {
    func swipeHappenOnCell(cell: CustomCardsTableViewCell, direction: SwipeDirection )
}


class CustomCardsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardOptionsContentView: UIView!
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var buttonCardPayNow:UIButton!
    @IBOutlet weak var buttonCardViewDetail:UIButton!
    
    var delegate : SwipGestureProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetUp()
        // Initialization code
    }

    func commonSetUp() {
        //Set Rounded Corner
        cardImageView.makeCornerRadiusRounded()
        cellContentView.makeCornerRadiusRounded()
        
        //Add Swipe Action:
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(swipeMade(_:)))
           leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(swipeMade(_:)))
           rightRecognizer.direction = .right
       self.cardImageView.addGestureRecognizer(leftRecognizer)
       self.cardImageView.addGestureRecognizer(rightRecognizer)
    }
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
       if sender.direction == .left {
            self.delegate?.swipeHappenOnCell(cell: self, direction: .left)
       }
       if sender.direction == .right {
           self.delegate?.swipeHappenOnCell(cell: self, direction: .right)
       }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}

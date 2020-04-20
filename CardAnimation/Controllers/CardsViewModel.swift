//
//  CardsViewModel.swift
//  Cred.Com
//
//  Created by IMAC-0025 on 12/01/20.
//  Copyright © 2020 IMAC-0025. All rights reserved.
//

import Foundation
import UIKit

class CardsViewModel {
    
    //Array to hold cards with their Status
    var allCardsArray = [Card(cardImageName: "americanCard", isExpanded: false),Card(cardImageName: "sbiCard", isExpanded: false),Card(cardImageName: "hdfcCard", isExpanded: false)]
    
    //Default Initiliser
    init() {
        
    }
    
    //Total number of cards
    func getTotalNumberOfCount() -> Int {
        return self.allCardsArray.count
    }
    
    //
    func imageForRowAtIndex(index: Int) -> String {
        self.allCardsArray[index].cardImageName
    }
    
}

//This extension will handle Swipe logic
extension ViewController: SwipGestureProtocol, UIScrollViewDelegate {
    
    func swipeHappenOnCell(cell: CustomCardsTableViewCell, direction: SwipeDirection) {
        //Keep perticuar cell open and other close
        for i in 0..<self.cardModel.allCardsArray.count {
            if i == cell.buttonCardPayNow.tag {
                self.cardModel.allCardsArray[cell.buttonCardPayNow.tag].isExpanded = true
            }else{
                self.cardModel.allCardsArray[i].isExpanded = false
            }
        }
        //Swipe based on direction
        switch direction {
            case .left:
                self.swipeLeftCreditCardWithAnimation(cell)
            case .right:
                self.swipeRightCreditCardWithAnimation(cell)
        
        }
        //Refresh cell
       refreshTableViewToUpdateCardCellToDefaultState(false)
    }
    //Swipe Left
    func swipeLeftCreditCardWithAnimation(_ cell: CustomCardsTableViewCell)   {
           UIView.animate(withDuration: kAnimationDuration, animations: {
               cell.cardImageView.transform = CGAffineTransform(translationX: -cell.cardImageView.frame.width/2 , y: 0)
               cell.cardOptionsContentView.transform =  CGAffineTransform(translationX: cell.cardOptionsContentView.frame.width/2 , y: 0)
           })
    }
     //Swipe Right
    func swipeRightCreditCardWithAnimation(_ cell: CustomCardsTableViewCell) {
           UIView.animate(withDuration: kAnimationDuration, animations: {
                cell.cardImageView.transform = CGAffineTransform(translationX: cell.cardImageView.frame.width/2 , y: 0)
                cell.cardOptionsContentView.transform =  CGAffineTransform(translationX: -cell.cardOptionsContentView.frame.width/2 , y: 0)
           })
    }
    //Move card to center position
    func moveToOriginalPosition(cell: CustomCardsTableViewCell) {
        UIView.animate(withDuration: kAnimationDuration, animations: {
             cell.cardImageView.transform = .identity
             cell.cardOptionsContentView.transform = .identity
       })
    }
       
    //MARK: - UISrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        refreshTableViewToUpdateCardCellToDefaultState(true)
    }
    //Re-set cell
    func refreshTableViewToUpdateCardCellToDefaultState(_ isVerticalScroll: Bool) {
        for cell in self.creditCardsListTableView.visibleCells  {
            if let customCell = cell as? CustomCardsTableViewCell {
                if self.cardModel.allCardsArray[customCell.buttonCardPayNow.tag].isExpanded == false || isVerticalScroll == true {
                    self.moveToOriginalPosition(cell: customCell)
                }
           }
        }
    }
}


//Extension for TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // No of Cards
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardModel.getTotalNumberOfCount()
    }
    //Configure Cell data
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cardCell = tableView.dequeueReusableCell(withIdentifier:kSTRING_CONSTANT_CARDCELLIDENTIFIRE, for: indexPath) as! CustomCardsTableViewCell
        
        cardCell.cardImageView.image = UIImage(named: self.cardModel.imageForRowAtIndex(index: indexPath.row))
        cardCell.buttonCardPayNow?.tag = indexPath.row
        cardCell.buttonCardViewDetail?.tag = indexPath.row
        //Set swipe delegate to self
        cardCell.delegate = self
        //Default heighlight selection changed to clear
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cardCell.selectedBackgroundView = backgroundView

        return cardCell
    }
    //height for Cell
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(kHeightForTableCell)
    }
}

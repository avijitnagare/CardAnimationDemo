//
//  Constants.swift
//  CREDDemo
//
//  Created by IMAC-0025 on 16/11/19.
//  Copyright © 2019 IMAC-0025. All rights reserved.
//

import Foundation
import UIKit

let kSTRING_CONSTANT_CARDCELLIDENTIFIRE = "cardCell"
let kAPPCOLOR = UIColor(displayP3Red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
let kAnimationDuration = 0.6
let kHeightForTableCell = 220.0

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String {
        let unreserved = ""
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        return self.addingPercentEncoding(withAllowedCharacters:allowed)!
    }
}

extension UIView {
    func makeCornerRadiusRounded() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}




extension UITableView {
    func reloadData(completion: @escaping  ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) {  (true) in
            completion()
        }
    }
}

extension UIViewController {
    func alert(title: String = "",message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

struct Constants {
    struct Service {
        static let BaseURL = "http://starlord.hackerearth.com/"
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
    }
    
}
func getAppColor() -> UIColor {
    return #colorLiteral(red: 0.06618922204, green: 0.07779940218, blue: 0.1110001281, alpha: 1)
}
func getAppTintColor() -> UIColor {
    return #colorLiteral(red: 0.622913003, green: 0.7640128732, blue: 0.8310886025, alpha: 1)
}
func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
}


public func requestGenericData(urlString: String, httpMethod: String, token: String,completion:@escaping(_ result: Data?,_ success:Bool)-> Void) {
    
    let fullStringUrl: String = Constants.Service.BaseURL + urlString
    let urlReq = URL(string: fullStringUrl)
    var urlRequest = URLRequest(url: urlReq!)
    urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
    // urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    urlRequest.httpMethod = httpMethod
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        
        guard let data = data else { return }
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                //do {
                // let parsedObj = try JSONDecoder().decode(T.self, from: data)
                completion(data,true)
                //  } catch {
                //                        print("Error: \(String(describing: error))\n StatusCode: \(httpResponse.statusCode)")
                //                        completion(nil,false)
                //                    }
            }else{
                completion(nil,false)
            }
        } else {
            completion(nil,false)
        }
        }.resume()
    
}

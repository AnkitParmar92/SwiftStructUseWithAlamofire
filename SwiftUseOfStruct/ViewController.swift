//
//  ViewController.swift
//  SwiftUseOfStruct
//
//  Created by apple on 30/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UICollectionViewController {

    var data1 = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Data()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func Data(){
        let Url = URL(string: "https://raw.githubusercontent.com/Abhishekverma99/Use-swift-3.0/master/db.json")
        Alamofire.request(Url!).validate().responseJSON { (response) in
            
            if ((response.result.value) != nil)
            {
                let jsondata = JSON(response.result.value!)
                print(jsondata)
                
                if let da = jsondata["movies"].arrayObject
                {
                    self.data1 = da as! [[String: AnyObject]]
                }
                
                if self.data1.count > 0{
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return data1.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let dictionary = data1[indexPath.row]
        
        cell.NAME.text = dictionary["name"] as? String
        
        let a = dictionary["id"] as? Int
        let b = String(describing: a!)
        cell.ID.text = b
        
        cell.DirectorName.text = dictionary["director"] as? String
        
        let a1 = dictionary["rating"] as? CGFloat
        let b1 = String(describing: a1!)
        cell.Rating.text = b1
        
        return cell
    }


}


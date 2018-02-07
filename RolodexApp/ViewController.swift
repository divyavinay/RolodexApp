//
//  ViewController.swift
//  RolodexApp
//
//  Created by Divya Basappa on 2/6/18.
//  Copyright © 2018 Divya Basappa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://s3-us-west-2.amazonaws.com/udacity-mobile-interview/CardData.json"
        let dataProvider = DataProvider()
        dataProvider.fetchData(urlString: urlString) { (dictionary) in
            for card in dictionary {
                 let cardDetails = Card(dictionary: card)
                 print(cardDetails?.firstName ?? "No value")
                 print(cardDetails?.lastName ?? "No value")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


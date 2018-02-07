//
//  MasterCollectionViewController.swift
//  RolodexApp
//
//  Created by Divya Basappa on 2/6/18.
//  Copyright © 2018 Divya Basappa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

var cardDetails = [JSONDictionary]()

class MasterCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://s3-us-west-2.amazonaws.com/udacity-mobile-interview/CardData.json"
         let dataProvider = DataProvider()
         dataProvider.fetchData(urlString: urlString) { (dictionary) in
            for card in dictionary {
                cardDetails.append(card)
            }
        }
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return cardDetails.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }


}

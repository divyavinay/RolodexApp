//
//  SwipingController.swift
//  RolodexApp
//
//  Created by Divya Basappa on 2/6/18.
//  Copyright © 2018 Divya Basappa. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var cards = [Card]()
    let dataProvider = DataProvider()
    private var fetchUrlString = "https://s3-us-west-2.amazonaws.com/udacity-mobile-interview/CardData.json"
    private let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData { (cards) in
            self.cards = cards
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func fetchData(completion: @escaping ([Card]) -> Void) {
        var cards = [Card]()
        dataProvider.fetchData(urlString: fetchUrlString) { (dictionary) in
            for card in dictionary {
                if let cardDetails = Card(dictionary: card) {
                    cards.append(cardDetails)
                    completion(cards)
                }
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PageCell
        cell?.descriptionTextView.text = "Bio: \(cards[indexPath.row].bio)" 
        cell?.firstName.text = "First name: \(cards[indexPath.row].firstName)"
        cell?.lastName.text = "Last name: \(cards[indexPath.row].lastName)"
        dataProvider.downloadImage(urlString: cards[indexPath.row].avatar) { (image) in
            DispatchQueue.main.async {
                cell?.imageView.image = image
            }
        }
        guard let pageCell = cell else {
            return PageCell()
        }
        
        return pageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

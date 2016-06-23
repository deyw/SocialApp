//
//  PostFeedsVC.swift
//  SocialApp
//
//  Created by VLADISLAV TAIURSKIY on 23.06.16.
//  Copyright © 2016 Vladislav Taiurskiy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PostFeedsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Post Feeds"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(235, green: 235, blue: 235)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.rgb(243, green: 241, blue: 241)
        collectionView?.register(PostFeedsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
 
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // temp value
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 460)
    }



}

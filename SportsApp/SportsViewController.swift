//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Khairy on 16/05/2025.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    let sports: [String] = ["Football", "Basketball", "Tennis", "Cricket"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCell
        
        cell.sportImage.image = UIImage(named: sports[indexPath.row])
        cell.sportName.text = sports[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let spacing: CGFloat = 10
        let totalSpacing = (itemsPerRow - 1) * spacing
        
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        let height = collectionView.bounds.height / 2 - spacing
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sportLeaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "SportLeaguesViewController") as! SportLeaguesViewController
        sportLeaguesViewController.sportName = sports[indexPath.row]
        self.navigationController?.pushViewController(sportLeaguesViewController, animated: true)
    }
    
}

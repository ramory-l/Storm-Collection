//
//  CollectionViewController.swift
//  Project1
//
//  Created by Mikhail Strizhenov on 16.04.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items.sorted() {
            if item.hasPrefix("nssl") {
                let picture = Picture(name: item, image: item)
                pictures.append(picture)
            }
        }
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(appRecommendation), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue CollectionViewCell.")
        }
        
        let picture = pictures[indexPath.item]
        
        cell.name.text = picture.name
        
        cell.imageView.image = UIImage(named: picture.image)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.imageNumber = indexPath.row + 1
            vc.numberOfImages = pictures.count
            vc.selectedImage = pictures[indexPath.item].image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func appRecommendation() {
        let alert = UIAlertController(title: "Like our app?", message: "Please, recommend our app to other people!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sure!", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

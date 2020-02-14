//
//  FavoriteVC.swift
//  DemoApp
//
//  Created by WESLEY on 2020/2/14.
//  Copyright © 2020 Wesley. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    
    
    lazy var PhotoCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.backgroundColor = .white
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initTitle()
        PhotoCollectionView.reloadData()
    }
    
    
    func initTitle() {
        tabBarController?.title = "我的最愛"
        navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    }
    
    func initView() {
        view.backgroundColor = .white
        view.addSubview(PhotoCollectionView)
        PhotoCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        PhotoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        PhotoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        PhotoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        PhotoCollectionView.delegate = self
        PhotoCollectionView.dataSource = self
        PhotoCollectionView.register(PhotoCVC.self, forCellWithReuseIdentifier: "Cell")
    }
    
    @objc func refresh() {
        
        titles = []
        imageURLs = []
        UserDefaults.standard.setValue(titles, forKey: "titles")
        UserDefaults.standard.setValue(imageURLs, forKey: "imageURLs")
        PhotoCollectionView.reloadData()
    }
    
}

extension FavoriteVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVC
        // Configure the cell
        cell.title.text = titles[indexPath.row]
        cell.imageURL = URL(string: imageURLs[indexPath.row])!
        cell.PhotoImageView.image = nil
        cell.indexPathRow = indexPath.row
        cell.favoriteBtn.isHidden = true
        NetworkUtility.downloadImage(url: cell.imageURL) { (image) in
            if cell.imageURL == URL(string: imageURLs[indexPath.row])!, let image = image  {
                DispatchQueue.main.async {
                    cell.PhotoImageView.image = image
                }
            }
          
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2 - 10
        
        return CGSize(width: width, height: width)
        
    }
    
    
}

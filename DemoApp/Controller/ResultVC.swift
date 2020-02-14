//
//  ResultVC.swift
//  DemoApp
//
//  Created by WESLEY on 2020/2/14.
//  Copyright © 2020 Wesley. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    
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
    
    
    var loadingView: LoadingView?
    
    var Photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getPhoto()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initTitle()
    }
    
    
    func initTitle() {
        self.tabBarController?.title = "搜尋結果 \(Content)"
        navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = nil
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
    
    func getPhoto() {
        
        loadingView = LoadingView(frame: UIScreen.main.bounds)
        view.addSubview(self.loadingView!)

        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=d88a1180d3634290d2d6692bcc08b0d9&format=json&nojsoncallback=1&text=\(Content)&per_page=\(PageNum)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let searchData = try? JSONDecoder().decode(SearchData.self, from: data) {
                    self.Photos = searchData.photos.photo
                    DispatchQueue.main.async {
                        self.PhotoCollectionView.reloadData()
                        if self.loadingView != nil {
                            self.loadingView?.removeFromSuperview()
                        }
                    }
                }
            }
   
            task.resume()
        }
    }

}

extension ResultVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , PhotoCVC_Delegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVC
        // Configure the cell
        let photo = Photos[indexPath.item]
        cell.title.text = photo.title
        cell.imageURL = photo.imageUrl
        cell.PhotoImageView.image = nil
        cell.delegate = self
        cell.indexPathRow = indexPath.row
        NetworkUtility.downloadImage(url: cell.imageURL) { (image) in
            if cell.imageURL == photo.imageUrl, let image = image  {
                DispatchQueue.main.async {
                    cell.PhotoImageView.image = image
                }
            }
            if imageURLs.contains(cell.imageURL.absoluteString) {
                DispatchQueue.main.async {
                    cell.favoriteBtn.setTitleColor(.red, for: .normal)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width / 2 - 10
        
        return CGSize(width: width, height: width)
        
    }
    
    func AddBtnTap(indexPathRow: Int) {
        
        let photo = Photos[indexPathRow]
        
        let cell = PhotoCollectionView.cellForItem(at: IndexPath(row: indexPathRow, section: 0)) as! PhotoCVC
        
        if let index = imageURLs.firstIndex(of: photo.imageUrl.absoluteString) {
            titles.remove(at: index)
            imageURLs.remove(at: index)
            cell.favoriteBtn.setTitleColor(.red, for: .normal)
        } else {
            imageURLs.append(photo.imageUrl.absoluteString)
            titles.append(photo.title)
            cell.favoriteBtn.setTitleColor(.red, for: .normal)
        }
        UserDefaults.standard.setValue(titles, forKey: "titles")
        UserDefaults.standard.setValue(imageURLs, forKey: "imageURLs")
    }
    
    
}




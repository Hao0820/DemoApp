//
//  PhotoCVC.swift
//  WeLike
//
//  Created by Wesley on 2019/10/31.
//  Copyright © 2019 Charles Chiang. All rights reserved.
//

import UIKit

protocol PhotoCVC_Delegate {
    func AddBtnTap(indexPathRow: Int)
}

class PhotoCVC: UICollectionViewCell {
    
    lazy var PhotoImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    lazy var title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("加入最愛", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(addBtnTap), for: .touchUpInside)
        return btn
    }()
    
    var imageURL: URL!
    var indexPathRow: Int!
    var delegate: PhotoCVC_Delegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //initialize all your subviews.
        self.backgroundColor = .white
        contentView.addSubview(favoriteBtn)
        favoriteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        favoriteBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        favoriteBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        contentView.addSubview(title)
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: favoriteBtn.leadingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        contentView.addSubview(PhotoImageView)
        PhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        PhotoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        PhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        PhotoImageView.bottomAnchor.constraint(equalTo: favoriteBtn.topAnchor).isActive = true
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.textColor = .black
    }
    
    @objc func addBtnTap() {
        delegate?.AddBtnTap(indexPathRow: indexPathRow)
    }
    
    
}

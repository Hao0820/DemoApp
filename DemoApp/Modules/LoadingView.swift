//
//  loadingView.swift
//  OneDate
//
//  Created by Wesley on 2019/3/13.
//  Copyright © 2019 LiHouse. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    var indicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.indicator = self.getIndicatorView(frame)
        self.addSubview(self.indicator)
        self.indicator.startAnimating()
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.isUserInteractionEnabled = true // 吃事件
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func getIndicatorView(_ frame: CGRect) -> UIActivityIndicatorView{
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.color = .black
        indicator.tintColor = .black
        indicator.alpha = 1
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        return indicator
    }
    
    deinit {
        self.indicator.stopAnimating()
    }
}

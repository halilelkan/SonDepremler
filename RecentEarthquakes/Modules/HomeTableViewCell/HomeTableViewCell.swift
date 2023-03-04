//
//  HomeTableViewCell.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 23.02.2023.
//

import UIKit
import Lottie

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var backgroundViews: UIView!
    
    
    let jsonName = "sari"
    let jsonName1 = "yesil"
    let jsonName2 = "kirmizi"
    var animationView: LottieAnimationView! = nil
    
    func configure(with product: Product) {
        let fullName    = "\(product.date ?? "")"
        let fullNameArr = fullName.components(separatedBy: " ")

        let date = fullNameArr[0]
        let time = fullNameArr[1]
        
        self.dateLabel.text = "Tarih: \(date)"
        self.timeLabel.text = "Saat: \(time)"
        self.depthLabel.text = "Derinlik: \(product.depth ?? 0.0) km"
        self.sizeLabel.text = "\(product.mag ?? 0.0)"
        self.locationLabel.text = product.title
        
        var newMag = "\(product.mag ?? 0.0)"
        
        if newMag <= "3.5"{
            mag(total: 1)
        }
        if newMag >= "3.5"{
            mag(total: 2)
        }
        if newMag >= "5.0"{
            mag(total: 3)
        }
    }
    
    func mag(total:Int){
        switch total{
        case 1:
            let animation = LottieAnimation.named(jsonName1)
            animationView = LottieAnimationView(animation: animation)
            animationView!.frame = viewColor.bounds
            
            animationView!.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.viewColor.addSubview(self.animationView)
            animationView.addSubview(sizeLabel)
            self.animationView.play()
            
            self.backgroundViews.layer.borderWidth = 1.5
            self.backgroundViews.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            
        case 2:
            let animation = LottieAnimation.named(jsonName)
            animationView = LottieAnimationView(animation: animation)
            animationView!.frame = viewColor.bounds
            
            animationView!.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.viewColor.addSubview(self.animationView)
            animationView.addSubview(sizeLabel)
            self.animationView.play()
            self.backgroundViews.layer.borderWidth = 1.5
            self.backgroundViews.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case 3:
            let animation = LottieAnimation.named(jsonName2)
            animationView = LottieAnimationView(animation: animation)
            animationView!.frame = viewColor.bounds
            
            animationView!.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.viewColor.addSubview(self.animationView)
            animationView.addSubview(sizeLabel)
            self.animationView.play()
            self.backgroundViews.layer.borderWidth = 1.5
            self.backgroundViews.layer.borderColor = #colorLiteral(red: 0.7530931296, green: 0.07559445506, blue: 0.09625372662, alpha: 1)
        default:
            break
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

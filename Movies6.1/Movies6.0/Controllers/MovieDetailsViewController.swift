//
//  MovieDetailsViewController.swift
//  Movies6.0
//
//  Created by Stanislav Tereshchenko on 30.04.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    var movies: Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = posterImageView.bounds
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.001).cgColor, UIColor.black.withAlphaComponent(2.0).cgColor]
        gradientLayer.backgroundColor = .none
        posterImageView.layer.addSublayer(gradientLayer)
        
        let title = UILabel(frame: CGRect(x: 10, y: 215, width: 300, height: 21))
        title.text = movies.title
        title.font = UIFont(name: "Heavy", size: 20)
        title.textColor = UIColor.white
        
        let rat = UILabel(frame: CGRect(x: 340, y: 215, width: 50, height: 21))
        let shortPopularity = Double(round(10 * movies.popularity) / 10)
        let rating = String(shortPopularity)
        rat.text = rating
        rat.font = UIFont(name: "Heavy", size: 20)
        rat.textColor = UIColor.white
        
        let starImage = UIImage(systemName: "star.fill")
        let starImageView = UIImageView(image: starImage)
        starImageView.tintColor = UIColor.orange
        starImageView.frame = CGRect(x: 375, y: 215, width: 20, height: 20)
        
        self.overviewLabel.numberOfLines = 0
        self.overviewLabel.sizeToFit()
        
        let bigimview = posterImageView
        bigimview!.frame = posterImageView.bounds
        
        let frontim = UIImage(systemName: "play.circle")
        let frontimview = UIImageView(image: frontim)
        frontimview.tintColor = UIColor.orange
        frontimview.frame = CGRect(x: 160, y: 60, width: 100, height: 100)
        
        bigimview!.addSubview(frontimview)
        bigimview?.addSubview(title)
        bigimview?.addSubview(rat)
        bigimview?.addSubview(starImageView)
        
        let pressOnImage = UILongPressGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.pressOnImage))
        posterImageView.addGestureRecognizer(pressOnImage)
        posterImageView.isUserInteractionEnabled = true
        let defaultLink = "https://image.tmdb.org/t/p/w500/"
        let completeLink = defaultLink + movies.backdrop_path
        posterImageView.downloaded(from: URL(string: completeLink)!)
        overviewLabel.text = movies.overview
        releaseLabel.text = "Release: \(movies.release_date)"
    }
    
    @objc func pressOnImage() {
        
        let alert = UIAlertController(title: "Movie", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: nil))
        
        present(alert, animated: true)
    }
}

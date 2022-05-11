//
//  ViewController.swift
//  Movies6.0
//
//  Created by Stanislav Tereshchenko on 29.04.2022.
//

import UIKit

class MoviesViewController: UIViewController {
    private let baseUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=ed0957c3c3f2acb89d27b394e9612d5e"
    @IBOutlet weak var emblemLabel: UINavigationItem!
    @IBOutlet weak var baseTableView: UITableView!
    
    private var movies = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrapedUrl = URL(string: baseUrl) else {
            return
        }
        let request = URLRequest(url: unwrapedUrl)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
               (statusCode != 200 ||  error != nil) {
                print("error\(statusCode)")
                return
            }
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(ResultMovie.self, from: data){
                self.movies = result.results
                DispatchQueue.main.async {
                    
                    self.baseTableView.reloadData()
                }
            } else {
                return
            }
        }.resume()
        
        let backBarButton = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
        
        baseTableView.rowHeight = 350
        
        baseTableView.register(UINib(nibName: "BaseMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "BaseMovieTableViewCellIdn")
        
        baseTableView.dataSource = self
        baseTableView.delegate = self
        setupNavigationBar()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieDetailsViewController
        let movie = sender as? Movies
        vc.movies = movie
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMovie = movies[indexPath.row]
        performSegue(withIdentifier: "MovieDetailsViewControllerIdn", sender: selectMovie)
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = baseTableView.dequeueReusableCell(withIdentifier: "BaseMovieTableViewCellIdn") as? BaseMovieTableViewCell
        cell?.titleLabel.text = movies[indexPath.row].title
        let defaultLink = "https://image.tmdb.org/t/p/w500/"
        let completeLink = defaultLink + movies[indexPath.row].poster_path
        cell?.posterImage.downloaded(from: URL(string: completeLink)!)
        cell?.dateLabel.text = "Release: \(movies[indexPath.row].release_date)"
        cell?.overviewLabel.text = movies[indexPath.row].overview
        
        return cell ?? UITableViewCell()
        
    }
} 

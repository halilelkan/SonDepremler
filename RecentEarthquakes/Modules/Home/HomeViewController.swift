//
//  HomeViewController.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 23.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    //   MARK: - UI Elements -> Halil İbrahim Elkan..
    @IBOutlet weak var tableView: UITableView!
    var refreshControll = UIRefreshControl()
    
    //   MARK: - Properties -> Halil İbrahim Elkan..
    private var products: [Product] = []
    var nameis: String?
    //   MARK: - Life Cyle -> Halil İbrahim Elkan..
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.3098039216, blue: 0.3490196078, alpha: 1)
        refreshControll.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControll
        self.refreshControll.attributedTitle = NSAttributedString(string: "Yenile", attributes: [NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))])
        
    }
    //   MARK: - Functions -> Halil İbrahim Elkan..
    func fetchProducts() {
        
        let network = Network()
        
        network.request(endpointType: .live) { (result: Result<BaseResponse<[Product]>, CustomError>) in
            
            switch result {
            case .success(let response):
                
                self.products = response.result ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //   MARK: - Actions -> Halil İbrahim Elkan..
    
    @objc func refresh(_ sender: UIRefreshControl){
        viewWillAppear(true)
        self.refreshControll.endRefreshing()
    }
}
    //   MARK: - Extensions -> Halil İbrahim Elkan..
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        let product = products[indexPath.row]
        
        cell.configure(with: product)
        let view = UIView()
        view.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.selectedBackgroundView = view
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = HomeDetailsViewController()
        controller.titleString = products[indexPath.row].title ?? ""
        controller.sizeLabelString = "\(products[indexPath.row].mag ?? 0.0)"
        controller.depthLabelString = "\(products[indexPath.row].depth ?? 0.0)"
        controller.dateTimeLabelString = products[indexPath.row].date ?? ""
        controller.lat = "\(products[indexPath.row].lat ?? 0.0)"
        controller.lng = "\(products[indexPath.row].lng ?? 0.0)"
        controller.modalPresentationStyle = .custom
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}

//
//  DashboardViewController.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation
import UIKit
import SDWebImage

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var hartLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hartImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var bottomTabBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var latestNewsCollectionView: UICollectionView!
    private var dashboardViewModel: DashboardViewModel!
    private var dashboardFiltedViewModel: FilteredDashboardViewModel!
    var myMemberVariable: Int = 0
    private var dataSource : LatestNewsDataSource<LatestNewsCollectionViewCell,Articles>!
    private var dataSourceForTableView : FilteredNewsDataSource<NewsTableViewCell,Articles>!
    var theNewsItems: [Articles]?
    var filteredNewsItems: [Articles]?
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestNewsCollectionView.register(LatestNewsCollectionViewCell.nib(), forCellWithReuseIdentifier: LatestNewsCollectionViewCell.identifer)
        
        menuCollectionView.register(ButtonCollectionViewCell.nib(), forCellWithReuseIdentifier: ButtonCollectionViewCell.identifer)
        
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifer)
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.isUserInteractionEnabled = true
        
        getCountry()
        
        let menuLayout = UICollectionViewFlowLayout()
        menuLayout.itemSize = CGSize(width: 100, height: 30)
        menuLayout.scrollDirection = .horizontal
        menuLayout.minimumLineSpacing = 10
        menuLayout.minimumInteritemSpacing = 10
        self.menuCollectionView.collectionViewLayout = menuLayout
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 240)
        layout.scrollDirection = .horizontal
        self.latestNewsCollectionView.collectionViewLayout = layout
        
        UiChanges()
        UiUpdate()
    }
    
    @IBAction func SeeAllButtonPressed(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        newViewController.modalPresentationStyle = .fullScreen
//        newViewController.theNewsItem = item
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        profileLabel.textColor = .lightGray
        hartLabel.textColor = .lightGray
        homeLabel.textColor = Constants.Colors.PrimaryColor
        profileImage.image = UIImage(named: "ProfileNotSelect")
        hartImage.image = UIImage(named: "HartNotSelect")
        homeImage.image = UIImage(named: "Home")
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        profileLabel.textColor = .lightGray
        hartLabel.textColor = Constants.Colors.PrimaryColor
        homeLabel.textColor = .lightGray
        profileImage.image = UIImage(named: "ProfileNotSelect")
        hartImage.image = UIImage(named: "HartSelected")
        homeImage.image = UIImage(named: "HomeNotSelected")
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        profileLabel.textColor = Constants.Colors.PrimaryColor
        hartLabel.textColor = .lightGray
        homeLabel.textColor = .lightGray
        profileImage.image = UIImage(named: "ProfileSelected")
        hartImage.image = UIImage(named: "HartNotSelect")
        homeImage.image = UIImage(named: "HomeNotSelected")
    }
    
    func UiChanges () {
        categories = ["General", "Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
        
        bottomTabBarView.layer.cornerRadius = 28
    }
    
    func UiUpdate() {
        self.dashboardViewModel = DashboardViewModel()
        self.dashboardViewModel.bindNewsViewModelToController = {
            self.updateDataSource()
        }
        
        self.dashboardFiltedViewModel = FilteredDashboardViewModel()
        self.dashboardFiltedViewModel.bindFiltedNewsViewModelToController = {
            self.updateTableViewDataSource(selectedCategories: "Generalda")
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = LatestNewsDataSource(cellIdentifier: "LatestNewsCollectionViewCell", items: self.dashboardViewModel.newsData.articles ?? [], configureCell: { (cell, newsItem) in
            cell.latestNewsCellRegister(imageName: newsItem.urlToImage ?? "", auther: newsItem.author ?? "", topic: newsItem.title ?? "", description: newsItem.content ?? "")
            self.theNewsItems = self.dashboardViewModel.newsData.articles
        })
        
        DispatchQueue.main.async {
            self.latestNewsCollectionView.dataSource = self.dataSource
            self.latestNewsCollectionView.reloadData()
        }
    }
    
    func updateTableViewDataSource(selectedCategories: String) {
        self.dataSourceForTableView = FilteredNewsDataSource(cellIdentifier: "NewsTableViewCell", items: self.dashboardFiltedViewModel.newsData.articles ?? [], configureCell: { cell, newsItem in
            cell.registorCell(image: newsItem.urlToImage ?? "", author: newsItem.author ?? "", titel: newsItem.title ?? "", datetime: newsItem.publishedAt ?? "")
            self.filteredNewsItems = self.dashboardFiltedViewModel.newsData.articles
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSourceForTableView
            self.tableView.reloadData()
        }
    }
    
    func goToDetailView(item: Articles) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.theNewsItem = item
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func getCountry(){
        let langStr = Locale.current.regionCode?.lowercased()
        
        let coutryArray = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
        
        if coutryArray.contains(langStr ?? "us") {
            UserDefaults.standard.set(langStr, forKey: Constants.UserDefaultsName.regionCode)
        }
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailView(item: (self.filteredNewsItems?[indexPath.row])!)
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.latestNewsCollectionView {
            goToDetailView(item: (self.theNewsItems?[indexPath.row])!)
        } else if collectionView == self.menuCollectionView {
            
            self.dashboardFiltedViewModel.getHeadlineData(keyword: self.categories[indexPath.row])
            self.dashboardFiltedViewModel.bindFiltedNewsViewModelToController = {
                self.updateTableViewDataSource(selectedCategories: self.categories[indexPath.row])
            }
            
            myMemberVariable = indexPath.row
            menuCollectionView.reloadData()
        }
    }
}

extension DashboardViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifer, for: indexPath) as! ButtonCollectionViewCell
            
            if indexPath.row == myMemberVariable {
                cell.setButton(name: categories[indexPath.row], status: true)
            } else  {
                cell.setButton(name: categories[indexPath.row], status: false)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.menuCollectionView {
            return categories.count
        } else {
            return 0
        }
    }
}


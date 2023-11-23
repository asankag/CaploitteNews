//
//  SearchViewController.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/23/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    var categories = [String]()
    var filters = [Filter]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var resultCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var searchViewModel: SearchViewModel!
    private var dashboardViewModel: DashboardViewModel!
    private var dataSource : SearchNewsDataSource<NewsTableViewCell,Articles>!
    var myMemberVariable: Int = 0
    var theNewsItems: [Articles]?
    var lastSearchKeyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.register(ButtonCollectionViewCell.nib(), forCellWithReuseIdentifier: ButtonCollectionViewCell.identifer)
        
        filtersCollectionView.register(FilterButtonCollectionViewCell.nib(), forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifer)
        
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifer)
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.isUserInteractionEnabled = true
        
        let menuLayout = UICollectionViewFlowLayout()
        menuLayout.itemSize = CGSize(width: 100, height: 30)
        menuLayout.scrollDirection = .horizontal
        menuLayout.minimumLineSpacing = 10
        menuLayout.minimumInteritemSpacing = 10
        self.menuCollectionView.collectionViewLayout = menuLayout
        
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        filtersCollectionView.isUserInteractionEnabled = true
        
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.itemSize = CGSize(width: 100, height: 30)
        filterLayout.scrollDirection = .vertical
        filterLayout.minimumLineSpacing = 10
        filterLayout.minimumInteritemSpacing = 10
        self.filtersCollectionView.collectionViewLayout = filterLayout
        
        UiChanges()
    }
    
    func UiChanges() {
        categories = ["Filter", "General", "Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
        
        filters.append(Filter(name: "Recommended", status: false))
        filters.append(Filter(name: "Latest", status: true))
        filters.append(Filter(name: "Most Viewed", status: false))
        filters.append(Filter(name: "Relevancy", status: false))
        filters.append(Filter(name: "Popularity", status: false))
        
        resetButtonOutlet.layer.cornerRadius = 15
        saveButtonOutlet.layer.cornerRadius = 25
        resetButtonOutlet.layer.borderColor = UIColor.black.cgColor
        resetButtonOutlet.layer.borderWidth = 1
        bottomView.dropShadow()
//        bottomViewConstraint.constant = -300
        
        self.searchViewModel = SearchViewModel()
        
        self.dashboardViewModel = DashboardViewModel()
        self.dashboardViewModel.bindNewsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = SearchNewsDataSource(cellIdentifier: "NewsTableViewCell", items: self.dashboardViewModel.newsData.articles ?? [], configureCell: { (cell, newsItem) in
            cell.registorCell(image: newsItem.urlToImage ?? "", author: newsItem.urlToImage ?? "", titel: newsItem.title ?? "", datetime: newsItem.publishedAt ?? "")
            self.theNewsItems = self.dashboardViewModel.newsData.articles
            self.resultCountLabel.text = "About \(self.dashboardViewModel.newsData.totalResults ?? 0) results"
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    func updateDataSourceWithFilters(){
        
        self.dataSource = SearchNewsDataSource(cellIdentifier: "NewsTableViewCell", items: self.searchViewModel.newsData.articles ?? [], configureCell: { (cell, newsItem) in
            cell.registorCell(image: newsItem.urlToImage ?? "", author: newsItem.author ?? "", titel: newsItem.title ?? "", datetime: newsItem.publishedAt ?? "")
            self.theNewsItems = self.searchViewModel.newsData.articles
            self.lastSearchKeyword = self.lastSearchKeyword.replacingOccurrences(of:"%20", with: " ")
            self.resultCountLabel.text = "About \(self.searchViewModel.newsData.totalResults ?? 0) results for \(self.lastSearchKeyword)"
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    @IBAction func BackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        searchForValues(searchString: searchBar.text ?? "")
    }
    
    func searchForValues(searchString: String) {
        var filtersString = ""
        filters.indices.forEach { (index) in
            if filters[index].status == true {
                filtersString = filtersString + "," + (filters[index].name ?? "")
            }
        }
        if filtersString != "" {
            filtersString.remove(at: filtersString.startIndex)
        } else {
            filtersString = "Popularity"
        }
        filtersString = filtersString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Popularity"
        var searchText = searchString
        
        if searchText != "" {
            searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Bitcoin"
            lastSearchKeyword = searchText
            self.searchViewModel.getSearchData(keyword: searchText, sortBy: filtersString)
            self.searchViewModel.bindSearchedNewsViewModelToController = {
                self.updateDataSourceWithFilters()
            }
        } else {
            // do nothing
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        filters.indices.forEach { (index) in
            filters[index].status = false
        }
        filtersCollectionView.reloadData()
    }
    
    @IBAction func filterDownButton(_ sender: UIButton) {
        self.bottomViewConstraint.constant = -300.0
        UIView.animate(withDuration: 0.6) {
                self.view.layoutIfNeeded()
        }
    }
    
    func goToDetailView(item: Articles) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.theNewsItem = item
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
//        searchForValues(searchString: searchBar.text ?? "")
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.menuCollectionView {
            
            if indexPath.row == 0 {
                self.bottomViewConstraint.constant = 0
                UIView.animate(withDuration: 0.6) {
                        self.view.layoutIfNeeded()
                }
            } else {
                searchForValues(searchString: categories[indexPath.row])
                myMemberVariable = indexPath.row
                menuCollectionView.reloadData()
            }
        } else {
            if filters[indexPath.row].status == false {
                filters[indexPath.row].status = true
            } else {
                filters[indexPath.row].status = false
            }
            filtersCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.menuCollectionView {
            return categories.count
        } else {
            return filters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifer, for: indexPath) as! ButtonCollectionViewCell
            
            if indexPath.row == myMemberVariable {
                cell.setButton(name: categories[indexPath.row], status: true)
            } else  {
                cell.setButton(name: categories[indexPath.row], status: false)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifer, for: indexPath) as! FilterButtonCollectionViewCell
            
            cell.setButton(name: filters[indexPath.row].name ?? "", status: filters[indexPath.row].status ?? false)
            
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailView(item: (self.theNewsItems?[indexPath.row])!)
    }
}

extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchForValues(searchString: searchText)
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchForValues(searchString: searchBar.text ?? "")
    }
}

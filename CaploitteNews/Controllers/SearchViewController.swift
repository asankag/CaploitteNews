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
    
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var resultCountLabel: UILabel!
    var myMemberVariable: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.register(ButtonCollectionViewCell.nib(), forCellWithReuseIdentifier: ButtonCollectionViewCell.identifer)
        
        filtersCollectionView.register(FilterButtonCollectionViewCell.nib(), forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifer)
        
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
        categories = ["Filter", "Healthy", "Technology", "Finance", "Arts", "Sports"]
        
        filters.append(Filter(name: "Recommended", status: false))
        filters.append(Filter(name: "Latest", status: false))
        filters.append(Filter(name: "Most Viewed", status: false))
        filters.append(Filter(name: "Channel", status: false))
        filters.append(Filter(name: "Following", status: false))
        
        resetButtonOutlet.layer.cornerRadius = 15
        saveButtonOutlet.layer.cornerRadius = 25
        resetButtonOutlet.layer.borderColor = UIColor.black.cgColor
        resetButtonOutlet.layer.borderWidth = 1
        bottomView.dropShadow()
        bottomViewConstraint.constant = -300
    }
    
    @IBAction func BackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
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

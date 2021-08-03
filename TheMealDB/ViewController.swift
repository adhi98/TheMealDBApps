//
//  ViewController.swift
//  TheMealDB
//
//  Created by mac on 02/08/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControll: UIRefreshControl!
    var mealsViewModel = MealViewModel()
    var dataMeals = [Meals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inisialisasi protocol MealViewModel
        mealsViewModel.delegate = self
        //inisialisasi tableview
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "MealsTableViewCell", bundle: nil), forCellReuseIdentifier: "mealCell")
        //callApi
        mealsViewModel.getDataList()
        //refreshData
        addRefreshControll()
    }
    
    func showAlertError() {
        let alertController = UIAlertController(title: "Networking Failed!", message: "Something Went Wrong", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK",style: .default,handler: nil)
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //refreshcontroll
    func addRefreshControll() {
        refreshControll = UIRefreshControl()
        refreshControll?.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        tableView.addSubview(refreshControll)
        
    }
    
    @objc func refreshList(_ refreshControl: UIRefreshControl) {
        mealsViewModel.getDataList()
    }

}

//MARK: - TableDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMeals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealsTableViewCell
        cell.selectionStyle = .none
        cell.mealView.layer.cornerRadius = 20
        cell.mealView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.mealView.layer.shadowOpacity = 1
        cell.mealView.layer.shadowRadius = 5
        cell.mealView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.labelMeal.text = dataMeals[indexPath.row].strMeal
        cell.IM_Meal.sd_setImage(with: URL(string: dataMeals[indexPath.row].strMealThumb), placeholderImage: UIImage(named: "loading"), options: .continueInBackground, progress: nil) { (downloadImage, downloadException, cacheType, downloadURL) in

        }
        
        cell.IM_Meal.layer.cornerRadius = 20
        cell.IM_Meal.clipsToBounds = true
        
        return cell
    }


}

//MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationDetailMeals = segue.destination as! DetailViewController
        let idMeal = dataMeals[tableView.indexPathForSelectedRow!.row].idMeal
        destinationDetailMeals.mealsData = idMeal
    }
    
    
}



//MARK: - MealViewDelegate
extension ViewController: MealViewModelDelegate {
    func didUpdateMeals(meals: [Meals]) {
        DispatchQueue.main.async {
            self.dataMeals = meals
            print("count \(self.dataMeals.count)")
            self.tableView.reloadData()
            self.refreshControll?.endRefreshing()
        }
    }
    
    func didFailMeals(error: Error) {
        print("error \(error)")
        showAlertError()
        self.refreshControll?.endRefreshing()
    }
}


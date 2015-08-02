//
//  searchViewController.swift
//  Holmusk
//
//  Created by Vinupriya on 7/30/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit
import Realm

class searchViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnTotalIntake: UIButton!
    @IBOutlet weak var tblSearchView: UITableView!
    
    var arrFoodData : NSMutableArray = []
    var arrFoodSearch : NSMutableArray = []
    var objNutrients = RLMArray(objectClassName: nutrients.className())
    var arrValue = []
    var intialCondition : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        activityIndicator.startAnimating()
        searchBar.userInteractionEnabled = false
        
        var color = UIColor(red: 27.0/255.0, green: 64.0/255.0, blue: 121.0/255.0, alpha: 1)
        searchBar.delegate = self
        searchBar.barTintColor = color
        searchBar.backgroundColor = color
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = color.CGColor
        
        getFoodDataFromKiminoLabs() // get Data from kiminolabs
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        objNutrients.removeAllObjects()
        objNutrients.addObjects(nutrients.allObjects())
        if objNutrients.count == 0
        {
            btnTotalIntake.hidden = true
            tblBottomConstraint.constant = 0
        }
        else
        {
            btnTotalIntake.hidden = false
            tblBottomConstraint.constant = 50
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - searchBar Delegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
     if searchBar.text != nil
     {
        let predicate : NSPredicate = NSPredicate(format: "SELF contains[c] %@", searchBar.text)
        let arrSearch : NSArray = arrFoodData.filteredArrayUsingPredicate(predicate)
        
        arrFoodSearch.removeAllObjects()
        if arrSearch.count > 10
        {
          arrFoodSearch.addObjectsFromArray(arrSearch.subarrayWithRange(NSMakeRange(0, 10)))
        }
        else
        {
            arrFoodSearch.addObjectsFromArray(arrSearch as [AnyObject])
        }
        tblSearchView.reloadData()
        if arrFoodSearch.count == 0
        {
            tblSearchView.hidden = true
        }
        else
        {
            tblSearchView.hidden = false
        }
     }
     else
     {
        arrFoodSearch.removeAllObjects()
        tblSearchView.reloadData()
        tblSearchView.hidden = true
     }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        tblSearchView.hidden = true
        
        searchBar.resignFirstResponder()
        var urlCon = urlConnection()
        //service call to get data from Holmusk
        urlCon.serviceCall(searchBar.text, isKiminoCall:false, compClosure: { arrResult, dictResult, error in
            
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
            
            if error == nil
            {
               self.arrValue = arrResult!
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: {(alert : UIAlertAction!) in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                })
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            self.intialCondition = false
            self.tblView.reloadData()
        })
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        tblSearchView.hidden = true
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if arrValue.count == 0 && tableView == tblView
        {
            return tblView.frame.size.height
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if arrValue.count == 0 && tableView == tblView
        {
            let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultView") as! UIViewController
            let objResultView : resultView =  viewCon.view as! resultView
            if intialCondition
            {
              objResultView.lblResult.text = "Search some foods to know its nutrients value"
            }
            else
            {
              objResultView.lblResult.text = "No search result found"
            }
            objResultView.backgroundColor = objResultView.color
            return objResultView
        }
        else
        {
            return nil
        }
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tblView
        {
          return arrValue.count
        }
        else
        {
          return arrFoodSearch.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if tableView == tblView
        {
            var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.text = arrValue[indexPath.row].valueForKey("name") as? String
            return cell
        }
        else
        {
            var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell.textLabel?.text = arrFoodSearch[indexPath.row] as? String
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.contentView.backgroundColor = UIColor(red: 27.0/255.0, green: 64.0/255.0, blue: 121.0/255.0, alpha: 1)
            return cell
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if tableView == tblView
        {
         let portionsCon : portionsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("portionsViewController") as! portionsViewController
         portionsCon.dictValue = arrValue[indexPath.row] as! NSDictionary
         self.navigationController?.pushViewController(portionsCon, animated: true)
        }
        else
        {
            searchBar.text = arrFoodSearch.objectAtIndex(indexPath.row) as! String
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
    // MARK: - Local Functions
    
    @IBAction func btnTotal(sender: AnyObject) {
        let totalCon : totalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("totalViewController") as! totalViewController
        totalCon.IsParentNutrients = false
        self.navigationController?.pushViewController(totalCon, animated: true)
    }
    
    
    func getFoodDataFromKiminoLabs()
    {
        var urlCon = urlConnection()
        // service call to get data from kiminolabs
        urlCon.serviceCall(nil, isKiminoCall:true, compClosure: { arrResult, dictResult, error in
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
            self.searchBar.userInteractionEnabled = true
            
            if error == nil
            {
                let test : NSArray = dictResult.valueForKeyPath("results.collection") as! NSArray
                for dict in test
                {
                    self.arrFoodData.addObject(dict.valueForKeyPath("foodData.text")!)
                }
            }
            else
            {
                
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

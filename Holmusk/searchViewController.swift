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
    
    var objNutrients = RLMArray(objectClassName: nutrients.className())
    var arrValue = []
    var intialCondition : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.hidden = true
        var color = UIColor(red: 27.0/255.0, green: 64.0/255.0, blue: 121.0/255.0, alpha: 1)
        searchBar.delegate = self
        searchBar.barTintColor = color
        searchBar.backgroundColor = color
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = color.CGColor
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
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        searchBar.resignFirstResponder()
        var urlCon = urlConnection()
        urlCon.serviceCall(searchBar.text, compClosure: { arrResult, error in
            
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
        if arrValue.count == 0 
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
        if arrValue.count == 0
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
        return arrValue.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
       cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
       cell.textLabel?.text = arrValue[indexPath.row].valueForKey("name") as? String
       return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let portionsCon : portionsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("portionsViewController") as! portionsViewController
        portionsCon.dictValue = arrValue[indexPath.row] as! NSDictionary
        self.navigationController?.pushViewController(portionsCon, animated: true)
    }
    
    
    @IBAction func btnTotal(sender: AnyObject) {
        let totalCon : totalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("totalViewController") as! totalViewController
        totalCon.IsParentNutrients = false
        self.navigationController?.pushViewController(totalCon, animated: true)
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

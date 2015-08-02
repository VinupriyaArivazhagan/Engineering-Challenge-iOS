//
//  portionsViewController.swift
//  Holmusk
//
//  Created by Vinupriya on 7/30/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit

class portionsViewController: UIViewController {

    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var dictValue : NSDictionary!
    var arrValue : NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Portions"
        lblFoodName.text = dictValue.valueForKey("name") as? String
        arrValue = dictValue.valueForKey("portions") as! NSMutableArray
    }

    override func viewWillAppear(animated: Bool) {
      self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
           return 200
        }
        else
        {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if section == 0
        {
          var viewHeader = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 200))
          viewHeader.backgroundColor = UIColor.clearColor()
          return viewHeader
        }
        else
        {
          var viewHeader = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 50))
          viewHeader.backgroundColor = UIColor.clearColor()
          var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            
          visualEffectView.frame = viewHeader.bounds
          viewHeader.addSubview(visualEffectView)
          let lblInfo = UILabel(frame: CGRectMake(10, 0, view.frame.size.width-10, 50))
          lblInfo.text = "Nutrients of your searched food in portions"
          viewHeader.addSubview(lblInfo)
          return viewHeader
        }
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 1
        {
            return arrValue.count
        }
        else
        {
            return 0
        }
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
        let nutrientsCon : nutrientsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("nutrientsViewController") as! nutrientsViewController
        nutrientsCon.dictNutrients = arrValue[indexPath.row].valueForKey("nutrients") as! NSDictionary
        let name = arrValue[indexPath.row].valueForKey("name") as? String
        nutrientsCon.strName = lblFoodName.text! + " " + name!
        self.navigationController?.pushViewController(nutrientsCon, animated: true)
    }
    
    // MARK: - scroll View Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        // for parallax effect
        var yOffset = ((tblView!.contentOffset.y ) / 100) * 15.0
        viewScroll.contentOffset = CGPointMake(0.0, yOffset)
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

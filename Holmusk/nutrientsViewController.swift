//
//  nutrientsViewController.swift
//  Holmusk
//
//  Created by Vinupriya on 7/30/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit
import Realm

class nutrientsViewController: UIViewController {

    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var infoView: UILabel!
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    
    var strName : String!
    var dictNutrients : NSDictionary!
    var arrImportant : NSMutableArray = []
    var arrExtras : NSMutableArray = []
    var arrUnHandled : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nutrients"
        
        infoView.layer.cornerRadius = 10.0
        infoView.layer.masksToBounds = true
        
        btnAdd.layer.cornerRadius = btnAdd.frame.size.width/2
        btnAdd.layer.masksToBounds = true
        
        UIView.animateWithDuration(0.3, delay: 2.0, options: .CurveEaseOut, animations: {
            self.infoView.alpha = 0
            self.imgArrow.alpha = 0
            }, completion: { finished in
                self.infoView.removeFromSuperview()
                self.imgArrow.removeFromSuperview()
            })
        
        for (key, value) in dictNutrients.valueForKey("important") as! NSDictionary {
            arrImportant.addObject(key as! String)
        }
        
        for (key, value) in dictNutrients.valueForKey("extra") as! NSDictionary {
            arrExtras.addObject(key as! String)
        }
        
        arrUnHandled = dictNutrients.valueForKey("unhandled") as! NSArray
        
        lblName.text = strName 
        // Do any additional setup after loading the view.
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
          let lblInfo = UILabel(frame: CGRectMake(10, 0, view.frame.size.width - 10, 50))
          if section == 1
          {
            lblInfo.text = "Important"
          }
          else if section == 2
          {
            lblInfo.text = "Extras"
          }
          else if section == 3
          {
            lblInfo.text = "UnHandled"
          }
          viewHeader.addSubview(lblInfo)
          return viewHeader
        }
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if section == 1
        {
            return arrImportant.count
        }
        else if section == 2
        {
            return arrExtras.count
        }
        else if section == 3
        {
            return arrUnHandled.count
        }
        else
        {
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        if indexPath.section == 1
        {
            let key = arrImportant[indexPath.row] as! String
            if let value = dictNutrients.valueForKeyPath("important.\(key).value")  as? NSNumber
            {
               if let unit = dictNutrients.valueForKeyPath("important.\(key).unit") as? String
               {
                  cell.textLabel?.text = key + " : " + value.stringValue + " " + unit
                }
            }
            else
            {
                cell.textLabel?.text = key + " : 0"
            }
        }
        else if indexPath.section == 2
        {
            let key = arrImportant[indexPath.row] as! String
            if let value = dictNutrients.valueForKeyPath("extra.\(key).value")  as? NSNumber
            {
                if let unit = dictNutrients.valueForKeyPath("extra.\(key).unit") as? String
                {
                    cell.textLabel?.text = key + " : " + value.stringValue + " " + unit
                }
            }
            else
            {
                cell.textLabel?.text = key + " : 0"
            }
        }
        else if indexPath.section == 3
        {
            if let text = arrUnHandled[indexPath.row] as? String
            {
                cell.textLabel?.text = text
            }
            else
            {
                cell.textLabel?.text = "0"
            }
            
        }
        return cell
    }
    
    // MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // for prallax effect
        var yOffset = ((tblView!.contentOffset.y ) / 100) * 15.0
        viewScroll.contentOffset = CGPointMake(0.0, yOffset)
    }
    
    // MARK: - Local Declaration
    
    @IBAction func btnAdd(sender: AnyObject) {
        
        // To store data into Realm data storage
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        let objNutrients = nutrients()
        objNutrients.name = strName
        for index in 0...arrImportant.count-1
        {
            let content = contents()
            let key = arrImportant[index] as! String
            if let value = dictNutrients.valueForKeyPath("important.\(key).value")  as? NSNumber
            {
                if let unit = dictNutrients.valueForKeyPath("important.\(key).unit") as? String
                {
                    content.name = key
                    
                    if unit == "mg"
                    {
                        content.value = 1000.0 * value.doubleValue
                    }
                    else
                    {
                        content.value = value.doubleValue
                    }
                    content.unit = "g"
                }
            }
            else
            {
                content.name = key
                content.value = 0
                content.unit = "g"
            }
            objNutrients.content.addObject(content)
        }
        realm.addObject(objNutrients)
        realm.commitWriteTransaction()
        
        let totalCon : totalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("totalViewController") as! totalViewController
        totalCon.IsParentNutrients = true
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

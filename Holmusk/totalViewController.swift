//
//  totalViewController.swift
//  Holmusk
//
//  Created by Vinupriya on 7/31/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit
import Realm

class totalViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var objNutrients = RLMArray(objectClassName: nutrients.className())
    var IsParentNutrients: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Total Intake"
        
        // To retrieve data from realm data storage
        
        objNutrients.removeAllObjects()
        objNutrients.addObjects(nutrients.allObjects())
        
        if IsParentNutrients == true
        {
            let alertController = UIAlertController(title: "Message", message: "Nutrients added to your daily intake", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: {(alert : UIAlertAction!) in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRemoveIntake(sender: AnyObject) {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.deleteAllObjects()
        realm.commitWriteTransaction()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Int(objNutrients.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : chartCell = tableView.dequeueReusableCellWithIdentifier("chartCell", forIndexPath: indexPath) as! chartCell
        cell.objNutrients = objNutrients.objectAtIndex(UInt(indexPath.row)) as! nutrients
        cell.index = UInt(indexPath.row)
        cell.initialize()
        return cell
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

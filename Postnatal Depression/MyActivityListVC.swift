//
//  ListActivityRatesVC.swift
//  Postnatal Depression
//
//  Created by iParth on 1/3/17.
//  Copyright © 2017 Harloch. All rights reserved.
//

import UIKit

//var newItemArray:Array<String> = []
//var theNewCategory = ""
//var theCategory:Array<String> = []

class  MyActivityListVC: UIViewController {
    
    @IBOutlet weak var tblRates: UITableView!
    @IBOutlet weak var btnSheduleAnActivity: UIButton!
    
    //var categories:Array<String> = ["Nap","Watch a movie","Read a book","Make a good meal"]
    
    var SubCategories:Array<Dictionary<String,AnyObject>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        btnSheduleAnActivity.layer.cornerRadius = (btnSheduleAnActivity.frame.height/2)
        btnSheduleAnActivity.layer.masksToBounds = true
        
        tblRates.scrollEnabled = false
        
        SubCategories = SelectedCategory["SubCategories"] as? [Dictionary<String,AnyObject>] ?? []
        
        SelectedSubSubCategoryTitles = SelectedSubSubCategoryTitles.sort { (cat1, cat2) -> Bool in
            let NCat1 = cat1.stringByReplacingOccurrencesOfString(" ", withString: "")
            let NCat2 = cat2.stringByReplacingOccurrencesOfString(" ", withString: "")
            let VCat1:Float = NSUserDefaults.standardUserDefaults().floatForKey(NCat1) ?? 0
            let VCat2:Float = NSUserDefaults.standardUserDefaults().floatForKey(NCat2) ?? 0
            
            SelectedSubSubCategoryRates[NCat1] = 0
            return (VCat1 > VCat2)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func actionBackButton(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func actionSheduleAnActivityButton(sender: AnyObject) {
        //self.navigationController!.popViewControllerAnimated(true)
        
        //For test Going to How likely to accomplish screen
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("HowAccomplishVC") as? HowAccomplishVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return SelectedSubSubCategoryTitles.count
        //return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Main Category
        let cell:RateListTableViewCell = self.tblRates.dequeueReusableCellWithIdentifier("RateListTableViewCell") as! RateListTableViewCell
        let NCat1 = SelectedSubSubCategoryTitles[indexPath.row].stringByReplacingOccurrencesOfString(" ", withString: "")
        
        cell.lblCategoryTitle?.text = SelectedSubSubCategoryTitles[indexPath.row] ?? "-"
        cell.vRate?.tintColor = UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1)
        cell.vRate?.rating = 4
        
        cell.vRate?.rating = Double(NSUserDefaults.standardUserDefaults().floatForKey(NCat1) ?? 0)
        
        cell.vRate?.didFinishTouchingCosmos = { rating in
            print("rating : \(rating)")
            
            NSUserDefaults.standardUserDefaults().setFloat(Float(rating), forKey: NCat1)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        //cell.lblCategoryTitle?.text = SubCategories[indexPath.row]["Title"] as? String ?? "-"
        //cell.vRate?.tintColor = UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1)
        //cell.vRate?.value = 3
        //ImageName
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var currentCell:RateListTableViewCell?
        if let indexPath = tableView.indexPathForSelectedRow {
            currentCell = tableView.cellForRowAtIndexPath(indexPath) as? RateListTableViewCell
            SelectedSubSubCategoryTitle = (currentCell?.lblCategoryTitle!.text)
            
            self.tblRates.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
}

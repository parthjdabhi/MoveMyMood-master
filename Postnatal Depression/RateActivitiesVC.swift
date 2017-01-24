//
//  RateActivitiesVC.swift
//  Postnatal Depression
//
//  Created by iParth on 12/17/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import UIKit
//import HCSStarRatingView

class RateActivitiesVC: UIViewController {

    @IBOutlet weak var tblRates: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnNext.layer.cornerRadius = (btnNext.frame.height/2)
        btnNext.layer.masksToBounds = true
        
        tblRates.scrollEnabled = false
        
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
    
    @IBAction func actionNextButton(sender: AnyObject) {
        //self.navigationController!.popViewControllerAnimated(true)
        
        //For test Going to How likely to accomplish screen
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MyActivityListVC") as? MyActivityListVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return SelectedSubSubCategoryTitles.count
        //return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Main Category
        let cell:RateTableViewCell = self.tblRates.dequeueReusableCellWithIdentifier("RateTableViewCell") as! RateTableViewCell
        
        cell.lblCategoryTitle?.text = SelectedSubSubCategoryTitles[indexPath.row] ?? "-"
        cell.vRate?.tintColor = UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1)
        cell.vRate?.rating = 0
        
        //cell.listenOnVlaueChanged()
        //cell.vRate?.addTarget(self, action: Selector(self.didRatingValueChanged(cell.vRate!)), forControlEvents: UIControlEvents.ValueChanged)
        return cell
    }
    
//    @IBAction func didRatingValueChanged(view:CosmosView) {
//        print("Changed rateing to : \(view.value)")
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tblRates.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

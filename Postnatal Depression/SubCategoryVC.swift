//
//  MainCategoryVC.swift
//  Postnatal Depression
//
//  Created by iParth on 12/15/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import UIKit

class SubCategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    
    var SubCategories:Array<Dictionary<String,AnyObject>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.layer.cornerRadius = (btnNext.frame.height/2)
        btnNext.layer.masksToBounds = true
        
        lblTitle.text = SelectedCategory["MainCategory"] as? String
        SubCategories = SelectedCategory["SubCategories"] as? [Dictionary<String,AnyObject>] ?? []
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubCategories.count
        //return 15
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            //Main Category
            let cell:CategoryTableViewCell = self.tblCategory.dequeueReusableCellWithIdentifier("CategoryTableViewCell") as! CategoryTableViewCell
        
            cell.lblCategoryTitle?.text = SubCategories[indexPath.row]["Title"] as? String ?? "-"
        
            cell.imgCategory.backgroundColor = UIColor.grayColor()
            cell.imgCategory.layer.cornerRadius = (cell.imgCategory.frame.width/2)
            cell.imgCategory.layer.masksToBounds = true
            
            cell.imgCategory.image = UIImage(named:SubCategories[indexPath.row]["ImageName"] as? String ?? "ic_cat_placeholder")
            
            cell.imgStatus.hidden = false
            cell.imgCategory.hidden = false
        
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var currentCell:CategoryTableViewCell?
        currentCell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryTableViewCell

        //Value Selected
        print(currentCell?.lblCategoryTitle.text)

        SelectedSubCategory = SubCategories[indexPath.row]["Title"] as? String ?? "-"
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ListActivityRatesVC") as! ListActivityRatesVC!
        //next.categories =
        self.navigationController?.pushViewController(next, animated: true)
        
        //let next = self.storyboard?.instantiateViewControllerWithIdentifier("ListActivityRatesVC") as! ListActivityRatesVC!
        //self.navigationController?.pushViewController(next, animated: true)
    }
    
}

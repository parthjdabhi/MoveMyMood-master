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
    
//    var categories:Array<String> = ["At home","Outside","With others","Just for me"]
//    var items:Dictionary<String,AnyObject> = ["At home":["Self care", "Grooming", "Get your zen on", "Engage your senses", "Let your creative juices flow", "Household stuff", "Future and past fun"],"Outside":["Outside", "Grooming","Health", "Treat", "Exercise"],"With others":["Connect", "Meet with a friend","Romantic fun", "For others"],"Just for me":["Self care", "Grooming", "Get your zen on", "Engage your senses", "Let your creative juices flow", "Household stuff", "Future and past fun"]]
    
    var selectedSections:Array<Int> = []
    var selectedIndexpaths:Array<NSIndexPath> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.layer.cornerRadius = (btnNext.frame.height/2)
        btnNext.layer.masksToBounds = true
        btnNext.hidden = true
        
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
    
    @IBAction func actionNextButton(sender: AnyObject) {
        
        print("Slected counts : \(selectedIndexpaths.count)")
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("RateActivitiesVC") as! RateActivitiesVC!
        
        SelectedSubSubCategoryTitles = []
        for indexPath in selectedIndexpaths {
            if indexPath.row == 0 {
                continue
            }
            let SubSubCategories = (SubCategories[indexPath.section]["SubSubCategories"] as? Array<Dictionary<String,AnyObject>> ?? [])
            SelectedSubSubCategoryTitles.append(SubSubCategories[indexPath.row-1]["Title"] as? String ?? "-")
        }
        
        //let next = self.storyboard?.instantiateViewControllerWithIdentifier("MyActivityListVC") as! MyActivityListVC!
        
        
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SubCategories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return (SubCategories[section]["SubSubCategories"] as? Array<Dictionary<String,AnyObject>> ?? []).count
        //return SubCategories.count
        //return 15
        
        //selectedSections?.contains(section)
        if selectedSections.contains(section) {
            //Unselect section
            return 1 + (SubCategories[section]["SubSubCategories"] as? Array<Dictionary<String,AnyObject>> ?? []).count
        } else {
            //Expand submenu
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            //Main Category
            let cell:CategoryTableViewCell = self.tblCategory.dequeueReusableCellWithIdentifier("CategoryTableViewCell") as! CategoryTableViewCell
            
            cell.lblCategoryTitle?.text = SubCategories[indexPath.section]["Title"] as? String ?? "-"
            
            cell.imgCategory.backgroundColor = UIColor.grayColor()
            cell.imgCategory.layer.cornerRadius = (cell.imgCategory.frame.width/2)
            cell.imgCategory.layer.masksToBounds = true
            
            cell.imgCategory.image = UIImage(named:SubCategories[indexPath.row]["ImageName"] as? String ?? "ic_cat_placeholder")
            
            cell.imgStatus.hidden = false
            cell.imgCategory.hidden = false
            
            if selectedSections.contains(indexPath.section) {
                UIView.animateWithDuration(0.2, animations: {
                    cell.imgStatus.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2.5));
                })
            } else {
                UIView.animateWithDuration(0.2, animations: {
                    cell.imgStatus.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2.0));
                })
            }
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        } else {
            //Sub menu
            let cell:CategoryTableViewCell = self.tblCategory.dequeueReusableCellWithIdentifier("CategoryTableViewCell") as! CategoryTableViewCell
            
            let SubSubCategories = (SubCategories[indexPath.section]["SubSubCategories"] as? Array<Dictionary<String,AnyObject>> ?? [])
            
            if SubSubCategories.count > (indexPath.row-1) {
                cell.lblCategoryTitle?.text = SubSubCategories[indexPath.row-1]["Title"] as? String ?? "-"
            }
            
            cell.imgStatus.hidden = true
            cell.imgCategory.hidden = true
            
            
            
            if let index = selectedIndexpaths.indexOf(indexPath) {
                cell.selected = true
                cell.backgroundColor = UIColor.whiteColor()
            } else {
                cell.selected = false
                cell.backgroundColor = UIColor.whiteColor()
            }
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        var currentCell:CategoryTableViewCell?
        if let indexPath = tableView.indexPathForSelectedRow {
            currentCell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryTableViewCell
            print("\(currentCell?.lblCategoryTitle.text)")
        }
        
        if selectedSections.contains(indexPath.section) {
            if indexPath.row == 0 {
                UIView.animateWithDuration(0.2, animations: {
                    currentCell?.imgStatus.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2.0));
                })
                //Unselect section
                selectedSections.removeAtIndex(selectedSections.indexOf(indexPath.section) ?? 0)
                selectedIndexpaths = selectedIndexpaths.filter({ (section) -> Bool in
                    if section.section == indexPath.section {
                        return false
                    }
                    return true
                })
                //self.tblCategory.reloadData()
                self.tblCategory.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
                //self.tblCategory.deselectRowAtIndexPath(indexPath, animated: true)
            } else {
                //Value Selected
                print(currentCell?.lblCategoryTitle.text)
                
                selectedIndexpaths.append(indexPath)
                
                btnNext.hidden = (selectedIndexpaths.count > 0) ? false : true
                
                SelectedSubCategoryTitle = SubCategories[indexPath.row]["Title"] as? String ?? "-"
                let SubSubCategories = (SubCategories[indexPath.section]["SubSubCategories"] as? Array<Dictionary<String,AnyObject>> ?? [])
                SelectedSubSubCategoryTitle = (SubSubCategories.count > (indexPath.row-1)) ? SubSubCategories[indexPath.row-1]["Title"] as? String ?? "-" : "-"
                
                //let next = self.storyboard?.instantiateViewControllerWithIdentifier("RateActivitiesVC") as! RateActivitiesVC!
                //let next = self.storyboard?.instantiateViewControllerWithIdentifier("MyActivityListVC") as! MyActivityListVC!
                //self.navigationController?.pushViewController(next, animated: true)
            }
        } else {
            //Expand submenu
            UIView.animateWithDuration(0.2, animations: {
                currentCell?.imgStatus.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2.5));
            })
            
            if selectedSections.count > 0 {
                //self.tblCategory.reloadSections(NSIndexSet(index: selectedSections!), withRowAnimation: UITableViewRowAnimation.None)
                selectedSections.append(indexPath.section)
                //self.tblCategory.reloadData()
                self.tblCategory.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
                return
            }
            
            selectedSections.append(indexPath.section)
            //self.tblCategory.reloadData()
            self.tblCategory.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
        print("Selected counts : \(selectedIndexpaths.count)")
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let index = selectedIndexpaths.indexOf(indexPath) {
            selectedIndexpaths.removeAtIndex(index)
            let currentCell:CategoryTableViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? CategoryTableViewCell
            currentCell?.backgroundColor = UIColor.whiteColor()
        }
        btnNext.hidden = (selectedIndexpaths.count > 0) ? false : true
        
        print("Selected counts : \(selectedIndexpaths.count)")
    }
    
}

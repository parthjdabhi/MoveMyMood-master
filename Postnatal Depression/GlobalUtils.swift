import UIKit

public typealias blockAction = () -> Void
//var buttonAction: PopupDialogButtonAction?


let alertDurations:[String] = ["Notify me 15 mins before", "Notify me 30 mins before", "Notify me 45 mins before", "Notify me 60 mins before"]
let alertDurationsInMinute:[Int] = [15, 30, 45, 60]

let Barriers:[String] = ["Not enough time", "It seems hard", "Too tired"]
let BarriersSolution:[String] = ["Start Small even 5 minutes can help.", "Try activity of your interest", "Another dummy solution"]

var startDate:NSDate?
var alertBeforeStartDate:String?
var endDate:NSDate?
var alertBeforeEndDate:String?

// Categories Data
var Categories:[Dictionary<String,AnyObject>] = []
var SelectedCategory:Dictionary<String,AnyObject> = [:]
var SelectedSubCategory:Dictionary<String,AnyObject> = [:]

//Slected Titles
var SelectedCategoryTitle:String?
var SelectedSubCategoryTitle:String?
var SelectedSubSubCategoryTitle:String?
var SelectedSubSubCategoryTitles:Array<String> = []

var SelectedSubSubCategoryRates:Dictionary<String,AnyObject> = [:]


// // MARK: - Methods

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
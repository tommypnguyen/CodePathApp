//
//  EditFoodViewController.swift
//  SugoiFridge
//
//  Created by Angelo Domingo on 3/22/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Parse

class EditFoodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    @IBOutlet weak var compartmentField: UITextField!
    @IBOutlet weak var drawerField: UITextField!
    
    //var delegate
    var ingredient: PFObject!
    var index : Int?
    var selectedField : UITextField?
    var countryList = ["Algeria", "Andorra", "Angola", "India", "Taiwan", "Thailand"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deleteButton.layer.cornerRadius = CGFloat(CustomUI.cornerRadius.rawValue)
        populateUI()
        customizeTextFields()
    }
    
    @IBAction func change(_ sender: Any) {
        //print(ingredient.objectId!)
        
        if checkFieldsEmpty() {
            AlertControl.control.displayAlert(inVC: self, withTitle: ErrorMessages.editTitle.rawValue, andMsg: ErrorMessages.emptyMsg.rawValue)
        } else {
        
            let query = PFQuery(className:"Food")
            query.getObjectInBackground(withId: ingredient.objectId!) { (food: PFObject?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let food = food {
                    food["quantity"] = (self.quantityField.text as! NSString).integerValue
                    food["unit"] = self.unitField.text
                    food["compartment"] = self.compartmentField.text
                    food["aisle"] = self.drawerField.text
                    food.saveInBackground()
                }
            }
            
            self.performSegue(withIdentifier: "backToFoodSegue", sender: self)
        }
    }
    
    @IBAction func remove(_ sender: Any) {
        ingredient.deleteInBackground()
        
        self.performSegue(withIdentifier: "backToFoodSegue", sender: self)
    }
    
    
    func populateUI() {
        foodLabel.text        = (ingredient?["foodName"] as! String).capitalized
        quantityField.text    = "\(ingredient!["quantity"]!)"
        unitField.text        = (ingredient?["unit"] as! String)
        compartmentField.text = (ingredient?["compartment"] as! String)
        drawerField.text      = (ingredient?["aisle"] as! String)
        
        if ingredient?["image"] != nil {
            let foodImage = ingredient?["image"] as! PFFileObject
            foodImage.getDataInBackground { (imageData: Data?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let imageData = imageData {
                    self.foodImage.image = UIImage(data:imageData)!
                }
            }
        }
        
    }
    
    
    func customizeTextFields() {
        unitField.addTarget(self, action: #selector(unitFieldEditing), for: .editingDidBegin)
        compartmentField.addTarget(self, action: #selector(compartmentFieldEditing), for: .editingDidBegin)

    }
    
    @objc func unitFieldEditing() {
        selectedField = unitField
        createPickerView(for: unitField)
    }
    
    @objc func compartmentFieldEditing() {
        selectedField = compartmentField
        createPickerView(for: compartmentField)
    }
    
    @objc func drawerFieldEditing() {
        selectedField = drawerField
        createPickerView(for: drawerField)
    }
    
    func createPickerView(for field: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        field.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePicker))
        
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        field.inputAccessoryView = toolBar
    }
    
    @objc func closePicker() {
        selectedField = nil
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedField {
            case unitField:
                let units = ingredient?["possibleUnits"] as! [String]
                return units[row]
            
            case compartmentField:
                return Compartments.allValues[row].rawValue
                
            case drawerField:
                return countryList[row]
                
            default:
                return "Unknown"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch selectedField {
            case unitField:
                let units = ingredient?["possibleUnits"] as! [String]
                unitField.text = units[row]
            
            case compartmentField:
                compartmentField.text = Compartments.allValues[row].rawValue
                
            case drawerField:
                drawerField.text = countryList[row]
                
            default:
                break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedField {
            case unitField:
                let units = ingredient?["possibleUnits"] as! [String]
                return units.count
            
            case compartmentField:
                return Compartments.allValues.count
                
            case drawerField:
                return countryList.count
                
            default:
                return 0
        }
    }

    
    func checkFieldEmpty(_ field: UITextField) -> Bool {
            return field.text?.isEmpty ?? true
        }
        
    func checkFieldsEmpty() -> Bool {
        // TODO: drawerfield check might not be necessary if we use
        // a PickerView
        let quantityEmpty    = checkFieldEmpty(quantityField)
        let unitEmpty        = checkFieldEmpty(unitField)
        let compartmentEmpty = checkFieldEmpty(compartmentField)
        let drawerEmpty      = checkFieldEmpty(drawerField)
        
        return quantityEmpty || unitEmpty || compartmentEmpty || drawerEmpty
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

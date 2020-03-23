//
//  EditViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/15.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    @IBOutlet weak var compartmentField: UITextField!
    @IBOutlet weak var drawerField: UITextField!
    
    var delegate : IngredientsDelegate?
    var ingredient : Ingredient?
    var index : Int?
    var selectedField : UITextField?
    var countryList = ["Algeria", "Andorra", "Angola", "India", "Taiwan", "Thailand"]

    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateUI()
        customizeTextFields()
    }
    
    func populateUI() {
        nameLabel.text        = ingredient?.name.capitalized
        quantityField.text    = String(format: "%.1f", ingredient!.amount)
        unitField.text        = ingredient?.unit
        compartmentField.text = ingredient?.compartment
        drawerField.text      = ingredient?.aisle
        
        // Download large image from Spoonacular
        let urlString = SpoonacularAPI.image.rawValue + ImageSize.large.rawValue + "/" + ingredient!.imageName
        let url = URL(string: urlString)!
        
        // Assign image to UIImageView
        ingredientImage.af.setImage(withURL: url)
    }
    
    func customizeTextFields() {
        if (ingredient?.possibleUnits.count != 0) {
            unitField.addTarget(self, action: #selector(unitFieldEditing), for: .editingDidBegin)
        }
        
        if (Compartments.allValues.count != 0) {
            compartmentField.addTarget(self, action: #selector(compartmentFieldEditing), for: .editingDidBegin)
        }
        
        // TODO: whether to implement pickerview for drawer or have user
        // enter custom drawers?
        // drawerField.addTarget(self, action: #selector(drawerFieldEditing), for: .editingDidBegin)
    }
    
    
    // MARK: - PickerView delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedField {
            case unitField:
                return ingredient?.possibleUnits.count ?? 0
            
            case compartmentField:
                return Compartments.allValues.count
                
            case drawerField:
                return countryList.count
                
            default:
                return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedField {
            case unitField:
                return ingredient?.possibleUnits[row] ?? unitField.text
            
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
                unitField.text = ingredient?.possibleUnits[row] ?? unitField.text
            
            case compartmentField:
                compartmentField.text = Compartments.allValues[row].rawValue
                
            case drawerField:
                drawerField.text = countryList[row]
                
            default:
                break
        }
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
    
    
    // MARK: - Action Functions
    @IBAction func onDoneEditing(_ sender: Any) {
        // check if a single field is empty
        if checkFieldsEmpty() {
            AlertControl.control.displayAlert(inVC: self, withTitle: ErrorMessages.editTitle.rawValue, andMsg: ErrorMessages.emptyMsg.rawValue)
        }
        else {
            let newIngredient = Ingredient(id: ingredient!.id, name: ingredient!.name, image: ingredient!.image, imageName: ingredient!.imageName, unit: unitField.text!, amount: Double(quantityField.text!) ?? 0.0, aisle: drawerField.text!, cost: ingredient!.cost, possibleUnits: ingredient!.possibleUnits)
            
            delegate?.updateIngredient(with: newIngredient, at: index!)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Helper Functions
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
}

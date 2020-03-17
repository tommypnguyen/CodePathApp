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
    
    var ingredient : Ingredient?
    var index : Int?

    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateUI()
        customizeTextFields()
    }
    
    func populateUI() {
        nameLabel.text        = ingredient?.name
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
        unitField.addTarget(self, action: #selector(createPickerView), for: .editingDidBegin)
    }
    
    
    // MARK: - PickerView delegates
    var countryList = ["Algeria", "Andorra", "Angola", "India", "Thailand"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unitField.text = countryList[row]
    }
    
    @objc func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        unitField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePicker))
        
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        unitField.inputAccessoryView = toolBar
    }
    
    @objc func closePicker() {
          view.endEditing(true)
    }
}

//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 03.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var titleFontSize: CGFloat!
    var textFontSize: CGFloat!
    var hexSelectedColor: String?
    var selectedTitleFont: UIFontDescriptor?
    var selectedTextFont: UIFontDescriptor?
    
    let titleFontLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title font"
        return label
    }()
    
    let textFontLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text font"
        return label
    }()
    
    let titleFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.setTitle("Apple SD Gothic Neo-Bold", for: .normal)
        return button
    }()
    
    let textFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tag = 2
        button.setTitle("Apple SD Gothic Neo-Regular", for: .normal)
        return button
    }()
    
    let notesColorPicker =  UIColorPickerViewController()
    
    let titleFontSizeStepper: UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 20
        stepper.maximumValue = 100
        return stepper
    }()
    
    let textFontSizeStepper: UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 20
        stepper.maximumValue = 100
        return stepper
    }()
    
    let titleFontSizeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let titleFontPicker: UIPickerView = {
        let pv = UIPickerView(frame: .zero)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let textFontPicker: UIPickerView = {
        let pv = UIPickerView(frame: .zero)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let textFontSizeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let notesColorButton: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "circle.fill"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let notesColorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Notes color"
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        layoutSubviews()
        notesColorPicker.delegate = self
        titleFontSizeStepper.addTarget(self, action: #selector(titleStepperChanged), for: .valueChanged)
        textFontSizeStepper.addTarget(self, action: #selector(textStepperChanged), for: .valueChanged)
        titleFontButton.addTarget(self, action: #selector(fontTappped(sender:)), for: .touchUpInside)
        textFontButton.addTarget(self, action: #selector(fontTappped(sender:)), for: .touchUpInside)
        notesColorButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colopPickerTapped)))
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func addSubviews() {
        view.addSubview(notesColorButton)
        view.addSubview(titleFontSizeLabel)
        view.addSubview(textFontSizeLabel)
        view.addSubview(textFontSizeStepper)
        view.addSubview(notesColorLabel)
        view.addSubview(titleFontSizeStepper)
        view.addSubview(titleFontButton)
        view.addSubview(textFontButton)
        view.addSubview(titleFontLabel)
        view.addSubview(textFontLabel)
    }
    
    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            notesColorButton.widthAnchor.constraint(equalToConstant: 30),
            notesColorButton.heightAnchor.constraint(equalToConstant: 30),
            titleFontSizeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleFontSizeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleFontSizeStepper.topAnchor.constraint(equalTo: titleFontSizeLabel.bottomAnchor, constant: 16),
            titleFontSizeStepper.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFontSizeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFontSizeLabel.topAnchor.constraint(equalTo: titleFontSizeStepper.bottomAnchor, constant: 40),
            textFontSizeStepper.topAnchor.constraint(equalTo: textFontSizeLabel.bottomAnchor, constant: 16),
            textFontSizeStepper.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            notesColorLabel.topAnchor.constraint(equalTo: textFontSizeStepper.bottomAnchor, constant: 40),
            notesColorButton.topAnchor.constraint(equalTo: notesColorLabel.bottomAnchor, constant: 16),
            notesColorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            notesColorButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleFontLabel.topAnchor.constraint(equalTo: notesColorButton.bottomAnchor, constant: 40),
            titleFontLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleFontButton.topAnchor.constraint(equalTo: titleFontLabel.bottomAnchor, constant: 16),
            titleFontButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleFontButton.widthAnchor.constraint(equalToConstant: 200),
            titleFontButton.heightAnchor.constraint(equalToConstant: 50),
            textFontLabel.topAnchor.constraint(equalTo: titleFontButton.bottomAnchor, constant: 40),
            textFontLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFontButton.topAnchor.constraint(equalTo: textFontLabel.bottomAnchor, constant: 16),
            textFontButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func fontTappped( sender: UIButton) {
        
        let fontPicker = FontPickerViewController()
        fontPicker.delegate = self
        if sender === titleFontButton {
            fontPicker.tag = 1
        }
        
        if sender === textFontButton {
            fontPicker.tag = 2
        }
        
        self.present(fontPicker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPreviousData()
    }
    
    @objc private func titleStepperChanged(_ sender: UIStepper) {
        titleFontSize = sender.value
        titleFontSizeLabel.text = "Title font size: \(Int(titleFontSize!))"
    }
    
    @objc private func textStepperChanged(_ sender: UIStepper) {
        textFontSize = sender.value
        textFontSizeLabel.text = "Text font size: \(Int(textFontSize!))"
    }
    
    private func loadPreviousData() {
        
        //Getting font name from Settings
        let titleFontName = Settings.shared.titleFont?.fontName
        let textFontName = Settings.shared.textFont?.fontName
        
        // Populate buttons with font names
        textFontButton.setTitle(textFontName, for: .normal)
        titleFontButton.setTitle(titleFontName, for: .normal)
        
        // Get font size from Settings
        titleFontSize = (Settings.shared.titleFont?.pointSize)
        textFontSize = (Settings.shared.textFont?.pointSize)
        
        
        //Putting both name and size to var
        selectedTitleFont = UIFontDescriptor(name: titleFontName!, size: titleFontSize)
        selectedTextFont = UIFontDescriptor(name: textFontName!, size: textFontSize)
        
        //Populate label with font sizes
        titleFontSizeLabel.text = "Title font size: \(Int(titleFontSize))"
        textFontSizeLabel.text = "Text font size: \(Int(textFontSize))"
        
        // Setting steppers to font sizes
        titleFontSizeStepper.value = self.titleFontSize
        textFontSizeStepper.value = self.textFontSize
        
        // Getting color from Settings
        guard let color = Settings.shared.notesColor else { return }
        
        // Setting color picker and colorButton to right color
        notesColorPicker.selectedColor = UIColor(hexString: color)!
        notesColorButton.tintColor = UIColor(hexString: color)!
        // Putting color to var
        hexSelectedColor = color
    }
    
    
    @objc private func saveButtonPressed() {
        
        //Saving color to Settings and UserDefaults
        Settings.shared.notesColor = hexSelectedColor
        UserDefaults.standard.set(Settings.shared.notesColor, forKey: "notesColor")
        
        //Saving fonts to Settings and UserDefaults
        let textFont = UIFont(descriptor: selectedTextFont!, size: textFontSize)
        Settings.shared.textFont = textFont
        UserDefaults.standard.set(font: Settings.shared.textFont!, forKey: "textFont")
        
        let titleFont = UIFont(descriptor: selectedTitleFont!, size: titleFontSize)
        Settings.shared.titleFont = titleFont
        UserDefaults.standard.set(font: Settings.shared.titleFont!, forKey: "titleFont")
        
        // Presenting Alert
        let alert = UIAlertController(title: "Saved", message: "Your setting are saved!", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Close", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func colopPickerTapped() {
        present(notesColorPicker, animated: true)
    }
}


extension SettingsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        
        let selectedColor = viewController.selectedColor
        hexSelectedColor = selectedColor.RGB
        notesColorButton.tintColor = viewController.selectedColor
    }
}


extension SettingsViewController: UIFontPickerViewControllerDelegate {
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        
        let fontPicker = viewController as! FontPickerViewController
        
        if fontPicker.tag == 2 {
            guard let font = viewController.selectedFontDescriptor else { return }
            selectedTextFont = font
            textFontButton.setTitle(font.postscriptName, for: .normal)
        }
        
        if fontPicker.tag == 1 {
            guard let font = viewController.selectedFontDescriptor else { return }
            selectedTitleFont = font
            titleFontButton.setTitle(font.postscriptName, for: .normal)
        }
    }
}

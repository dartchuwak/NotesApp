//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 01.02.2023.
//

import UIKit
import CoreData


class NoteViewController: UIViewController {
    
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var note : Note!
    
    let noteTitleTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter note title"
        tf.borderStyle = .none
        tf.backgroundColor = .white
        return tf
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteText: UITextView = {
        let text = UITextView(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.cornerRadius = 0
        text.backgroundColor = .white
        text.font = UIFont.systemFont(ofSize: 18)
        return text
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configireBarButton()
        view.addSubview(noteTitleTextField)
        view.addSubview(titleLabel)
        view.addSubview(noteText)
        view.addSubview(descriptionLabel)
        layoutViews()
    }
    
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            noteTitleTextField.widthAnchor.constraint(equalToConstant: 200),
            noteTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: noteTitleTextField.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            noteText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    
    
    private func configireBarButton() {
        let save = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePressed))
        self.navigationItem.setRightBarButton(save, animated: true)
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        self.navigationItem.setLeftBarButton(closeButton, animated: true)
    }
    
    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func savePressed() {
        guard let noteTitle = noteTitleTextField.text else { return }
        guard let noteText = noteText.text else { return }
        self.save(title: noteTitle, text: noteText)
        navigationController?.popViewController(animated: true)
    }
    
    private func save(title: String, text: String) {
        
        if self.note != nil {
            note.title = title
            note.text = text
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext) else { return }
            let newNote = Note(entity: entity, insertInto: managedContext)
            newNote.title = title
            newNote.text = text
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}



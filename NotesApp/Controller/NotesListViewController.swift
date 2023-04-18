//
//  ViewController.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 01.02.2023.
//

import UIKit
import CoreData

class NotesListViewController: UIViewController {
    
    
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellId = "id"
    
    var titleFontSize: CGFloat!
    var textFontSize: CGFloat!
    
    let notesTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.allowsSelection = true
        tv.backgroundColor = .white
        return tv
    }()
    
    let addButton: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "plus.circle.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My notes"
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(notesTableView)
        view.addSubview(addButton)
        addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addNewNoteTapped)))
        layoutSunbviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if DetectLaunch.isFirst == false {
            fetchFromCoreData()
            notesTableView.reloadData()
        } else {
            getDataFromPlist()
            fetchFromCoreData()
            notesTableView.reloadData()
            DetectLaunch.isFirst = false
        }
    }
    
    @objc private func addNewNoteTapped() {
        let vc = NoteViewController()
        vc.title = "New note"
        navigationController?.pushViewController(vc, animated: true)
    }
 
    private func getDataFromPlist() {
        
        //Getting default note data from plist file
        //Getting path to plist file
        guard let pathToFile = Bundle.main.path(forResource: "defaultNote", ofType: "plist") else { return }
        guard let plistDictionary = NSDictionary(contentsOfFile: pathToFile) else { return }
        guard let defaultTitle = plistDictionary.value(forKey: "title") else { return }
        guard let defaultText = plistDictionary.value(forKey: "text") else { return }
        
        //Entity
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext) else { return }
        let note = NSManagedObject(entity: entity, insertInto: managedContext) as! Note
        
        note.title = defaultTitle as? String
        note.text = defaultText as? String
        
        //Save context to CoreData
        do {
           try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save to data base. \(error), \(error.userInfo)")
        }
    }
    
    private func fetchFromCoreData() {
        
        //Fetching data from CoreData
        let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let result = try managedContext.fetch(fetchRequest)
            notesArray = result
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
    
    @objc private func createNote() {
        navigationController?.pushViewController(NoteViewController(), animated: true)
    }
    
    private func layoutSunbviews() {
        notesTableView.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        NSLayoutConstraint.activate([
//            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            notesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0 ),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NotesTableViewCell
        let note = notesArray[indexPath.section]
        cell.titleLabel.text = note.title
        cell.descriptionLabel.text = note.text
        let color = Settings.shared.notesColor
        cell.backgroundColor = UIColor(hexString: color)
        cell.titleLabel.font = Settings.shared.titleFont
        cell.descriptionLabel.font = Settings.shared.textFont
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoteViewController()
        let note = notesArray[indexPath.section]
        vc.note = note
        vc.noteText.text = note.text
        vc.noteTitleTextField.text = note.title
        vc.title = "Edit note"
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            
            self.managedContext.delete(notesArray[indexPath.section])
            notesArray.remove(at: indexPath.section)
            do {
                try self.managedContext.save()
            } catch let error as NSError {
                print( error.localizedDescription)
            }
            let section = IndexSet(integer: indexPath.section)
            self.notesTableView.deleteSections(section, with: .automatic)
            complete(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         true
    }
}


//
//  ViewController.swift
//  CoreSpotlightDemo
//
//  Created by sama 刘 on 2021/8/20.
//

import UIKit
import CoreSpotlight

class ViewController: UIViewController {
    @IBOutlet weak var list: UITableView!
    var landMarks = ModelData().landMarks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = landMarks.map { mark -> CSSearchableItem in
            let itemAttributeSet: CSSearchableItemAttributeSet!
            if #available(iOS 14.0, *) {
                itemAttributeSet = CSSearchableItemAttributeSet(contentType: .text)
            } else {
                itemAttributeSet = CSSearchableItemAttributeSet(itemContentType: "text")
            }
            itemAttributeSet.identifier = "landmark_\(mark.id)"
            itemAttributeSet.keywords = [mark.name, "landmark", "旅游", mark.park]
            itemAttributeSet.title = mark.name
            itemAttributeSet.contentDescription = mark.description
            /// 也可以设置 URL
            itemAttributeSet.thumbnailData = mark.image?.pngData()
            /// ...
            /// uniqueIdentifier: Should be unique to your application group
            return CSSearchableItem(uniqueIdentifier: "com.hi.cage.CoreSpotlightDemo_\(mark.id)", domainIdentifier: "landmark", attributeSet: itemAttributeSet)
        }
        CSSearchableIndex.default().indexSearchableItems(items) { error in
            if let errMessage = error?.localizedDescription {
                debugPrint(errMessage)
            }
        }
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landMarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let mark = landMarks[indexPath.row]
        cell.landmarkImageView.image = mark.image
        cell.landmarkTitleLabel.text = mark.name
        cell.landmarkDescriptionLabel.text = mark.description
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let mark = landMarks.remove(at: indexPath.row)
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["com.hi.cage.CoreSpotlightDemo_\(mark.id)"]) { error in
            if let errMessage = error?.localizedDescription {
                debugPrint(errMessage)
            } else {
                debugPrint("deleteSearchableItems(withIdentifiers:) success")
            }
        }
        
        /// CSSearchableIndex.default().deleteSearchableItems(withDomainIdentifiers: <#T##[String]#>, completionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

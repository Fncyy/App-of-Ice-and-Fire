//
//  BookDetailViewController.swift
//  App of Ice and Fire
//
//  Created by user930278 on 11/13/21.
//

import UIKit
import Resolver

class BookDetailViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    // MARK: - Properties
    
    @Injected private var interactor: IceAndFireInteractor
    
    @IBOutlet weak var tableView: BookDetailTableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var bookId: Int!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.75
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
            
        tableView.viewController = self
        interactor.getBook(withId: bookId) { (book) in
            self.interactor.getCharacters(withIds: book.povCharacterIds) { (characterList) in
                DispatchQueue.main.async {
                    self.tableView.updateBook(book: book.toBookDetail(withPovCharacters: characterList.map{ $0.toCharacterReference() }))
                }
            }
        }
    }
    
    // MARK: - Previewing
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location),
                let cell = tableView.cellForRow(at: indexPath)
                else { return nil }
        previewingContext.sourceRect = cell.frame
        return tableView.instantiateViewController(at: indexPath)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
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

//
//  DocumentViewController.swift
//  SwiftPreview
//
//  Created by Marko Tadić on 2/17/19.
//  Copyright © 2019 AE. All rights reserved.
//

import UIKit
import Splash

class DocumentViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var document: UIDocument?

    override func viewDidLoad() {
        super.viewDidLoad()

        let backColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        view.backgroundColor = backColor
        textView.backgroundColor = backColor
        textView.isEditable = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { [weak self] (success) in
            guard let self = self else { return }
            if success {
                self.displayFile(at: self.document?.fileURL)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }

    private func displayFile(at url: URL?) {
        guard
            let url = url,
            let data = try? Data(contentsOf: url),
            let content = String(data: data, encoding: .utf8)
            else {
                return
        }
        let highlighter = SyntaxHighlighter(
            format: AttributedStringOutputFormat(
                theme: .sundellsColors(withFont: Font(size: 12))
            )
        )
        let attributedText = highlighter.highlight(content)
        textView.attributedText = attributedText
    }
}

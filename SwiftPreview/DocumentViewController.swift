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
    
    @IBOutlet weak var documentNameLabel: UILabel!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var document: UIDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { [weak self] (success) in
            guard let self = self else { return }
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent

                let highlighter = SyntaxHighlighter(
                    format: AttributedStringOutputFormat(
                        theme: .sundellsColors(withFont: Font(size: 12))
                    )
                )
                let attributedText = highlighter.highlight("func hello() -> String")

                self.textView.attributedText = attributedText

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
}

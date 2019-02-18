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

    private(set) var fontSize: CGFloat = 12 {
        didSet {
            if let font = textView.font {
                textView.font = font.withSize(fontSize)
            }
        }
    }

    private lazy var theme: Theme = {
        .sundellsColors(withFont: Font(size: Double(fontSize)))
    }()

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
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

    @objc
    func didRecognizeTapGesture(_ sender: UITapGestureRecognizer) {
        guard let nvc = navigationController else {
            return
        }
        nvc.setNavigationBarHidden(!nvc.isNavigationBarHidden, animated: true)
        nvc.setToolbarHidden(!nvc.isToolbarHidden, animated: true)
    }

    @objc
    func increaseFontSize(_ sender: UIBarButtonItem) {
        fontSize += 1
    }

    @objc
    func decreaseFontSize(_ sender: UIBarButtonItem) {
        fontSize -= 1
    }

    private func configure() {
        guard let nvc = navigationController else {
            return
        }

        let barStyle = UIBarStyle.black
        let barTint = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        let buttonTint = UIColor.orange

        nvc.navigationBar.barStyle = barStyle
        nvc.navigationBar.barTintColor = barTint
        nvc.navigationBar.tintColor = buttonTint

        nvc.setToolbarHidden(false, animated: false)
        nvc.toolbar.barStyle = barStyle
        nvc.toolbar.barTintColor = barTint
        nvc.toolbar.tintColor = buttonTint

        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(dismissDocumentViewController)
        )
        navigationItem.leftBarButtonItem = closeButton

        let buttonFont = UIFont.systemFont(ofSize: 32)
        let minusButton = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(decreaseFontSize(_:)))
        minusButton.setTitleTextAttributes([.font: buttonFont], for: .normal)
        let plusButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(increaseFontSize(_:)))
        plusButton.setTitleTextAttributes([.font: buttonFont], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [minusButton, flexibleSpace, plusButton]

        view.backgroundColor = theme.backgroundColor
        textView.backgroundColor = theme.backgroundColor
        textView.isEditable = false
        textView.isSelectable = false

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesture(_:)))
        textView.addGestureRecognizer(tapGesture)

        title = document?.fileURL.lastPathComponent
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
            format: AttributedStringOutputFormat(theme: theme)
        )
        let attributedText = highlighter.highlight(content)
        textView.attributedText = attributedText
    }
}

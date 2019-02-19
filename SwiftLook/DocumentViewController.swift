//
//  DocumentViewController.swift
//  SwiftLook
//
//  Created by Marko Tadić on 2/17/19.
//  Copyright © 2019 AE. All rights reserved.
//

import UIKit
import Splash

class DocumentViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var textView: UITextView!

    // MARK: Properties
    
    var document: Document?

    private(set) var fontSize: CGFloat = 12 {
        didSet {
            if let font = textView.font {
                textView.font = font.withSize(fontSize)
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Lifecycle

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
                self.textView.attributedText = self.document?.attributedText
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }

    // MARK: Actions

    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }

    @objc
    func didRecognizeTapGesture(_ sender: UITapGestureRecognizer) {
        toggleFullScreen()
    }

    @objc
    func increaseFontSize(_ sender: UIBarButtonItem) {
        fontSize += 1
    }

    @objc
    func decreaseFontSize(_ sender: UIBarButtonItem) {
        fontSize -= 1
    }

    // MARK: Helpers

    private func configure() {
        configureSelf()
        configureToolbars()
        configureButtons()
    }

    private func configureSelf() {
        title = document?.fileURL.lastPathComponent

        view.backgroundColor = document?.theme.backgroundColor

        textView.backgroundColor = document?.theme.backgroundColor
        textView.isEditable = false
        textView.isSelectable = false

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didRecognizeTapGesture(_:))
        )
        textView.addGestureRecognizer(tapGesture)
    }

    private func configureToolbars() {
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
    }

    private func configureButtons() {
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(dismissDocumentViewController)
        )
        navigationItem.leftBarButtonItem = closeButton

        let buttonFont = UIFont.systemFont(ofSize: 32)
        let minusButton = UIBarButtonItem(
            title: "-",
            style: .plain,
            target: self,
            action: #selector(decreaseFontSize)
        )
        minusButton.setTitleTextAttributes(
            [.font: buttonFont], for: .normal
        )
        let plusButton = UIBarButtonItem(
            title: "+",
            style: .plain,
            target: self,
            action: #selector(increaseFontSize)
        )
        plusButton.setTitleTextAttributes(
            [.font: buttonFont], for: .normal
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolbarItems = [minusButton, flexibleSpace, plusButton]
    }

    private func toggleFullScreen() {
        guard let nvc = navigationController else {
            return
        }
        nvc.setNavigationBarHidden(!nvc.isNavigationBarHidden, animated: true)
        nvc.setToolbarHidden(!nvc.isToolbarHidden, animated: true)
    }

}

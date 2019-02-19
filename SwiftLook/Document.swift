//
//  Document.swift
//  SwiftLook
//
//  Created by Marko Tadić on 2/17/19.
//  Copyright © 2019 AE. All rights reserved.
//

import UIKit
import Splash

class Document: UIDocument {

    // MARK: Properties

    var attributedText: NSAttributedString?

    lazy var theme: Theme = {
        .sundellsColors(withFont: Font(size: Double(12)))
    }()

    // MARK: Override

    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return try Data(contentsOf: fileURL)
    }

    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        guard let data = contents as? Data else {
            return
        }
        guard let content = String(data: data, encoding: .utf8) else {
            return
        }
        let highlighter = SyntaxHighlighter(
            format: AttributedStringOutputFormat(theme: theme)
        )
        attributedText = highlighter.highlight(content)
    }

}

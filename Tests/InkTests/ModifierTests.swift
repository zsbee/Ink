/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Ink

final class ModifierTests: XCTestCase {
    func testModifierInput() {
        var allHTML = [String]()
        var allMarkdown = [Substring]()

        let parser = MarkdownParser(modifiers: [
            HTMLModifier(target: .paragraphs) { html, markdown in
                allHTML.append(html)
                allMarkdown.append(markdown)
                return html
            }
        ])

        let html = parser.html(from: "One\n\nTwo\n\nThree")
        XCTAssertEqual(html, "<p>One</p><p>Two</p><p>Three</p>")
        XCTAssertEqual(allHTML, ["<p>One</p>", "<p>Two</p>", "<p>Three</p>"])
        XCTAssertEqual(allMarkdown, ["One", "Two", "Three"])
    }

    func testInitializingParserWithModifiers() {
        let parser = MarkdownParser(modifiers: [
            HTMLModifier(target: .links) { "LINK:" + $0.html },
            HTMLModifier(target: .inlineCode) { _ in "<em>Replacement</em>" }
        ])

        let html = parser.html(from: "Text [Link](url) `code`")

        XCTAssertEqual(
            html,
            #"<p>Text LINK:<a href="url">Link</a> <em>Replacement</em></p>"#
        )
    }

    func testAddingModifiers() {
        var parser = MarkdownParser()
        parser.addHTMLModifier(HTMLModifier(target: .headings) { _ in "<h1>New heading</h1>" })
        parser.addHTMLModifier(HTMLModifier(target: .links) { "LINK:" + $0.html })
        parser.addHTMLModifier(HTMLModifier(target: .inlineCode) { _ in "Code" })

        let html = parser.html(from: """
        # Heading

        Text [Link](url) `code`
        """)

        XCTAssertEqual(html, #"""
        <h1>New heading</h1><p>Text LINK:<a href="url">Link</a> Code</p>
        """#)
    }

    func testMultipleModifiersForSameTarget() {
        var parser = MarkdownParser()

        parser.addHTMLModifier(HTMLModifier(target: .codeBlocks) {
            " is cool:</p>" + $0.html
        })

        parser.addHTMLModifier(HTMLModifier(target: .codeBlocks) {
            "<p>Code" + $0.html
        })

        let html = parser.html(from: """
        ```
        Code
        ```
        """)

        XCTAssertEqual(html, "<p>Code is cool:</p><pre><code>Code\n</code></pre>")
    }
}

extension ModifierTests {
    static var allTests: Linux.TestList<ModifierTests> {
        return [
            ("testModifierInput", testModifierInput),
            ("testInitializingParserWithModifiers", testInitializingParserWithModifiers),
            ("testAddingModifiers", testAddingModifiers),
            ("testMultipleModifiersForSameTarget", testMultipleModifiersForSameTarget)
        ]
    }
}

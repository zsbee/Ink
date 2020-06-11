/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal struct Paragraph: Fragment {
    var modifierTarget: Target { .paragraphs }

    private var text: FormattedText

    static func read(using reader: inout Reader) -> Paragraph {
        return Paragraph(text: .read(using: &reader))
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: HTMLModifierCollection) -> String {
        let body = text.html(usingURLs: urls, modifiers: modifiers)
        return "<p>\(body)</p>"
    }

    func plainText() -> String {
        text.plainText()
    }
    
    
    func any(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> Any {
        return -1
    }
}

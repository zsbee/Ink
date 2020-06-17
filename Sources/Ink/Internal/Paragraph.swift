/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public struct Paragraph: Fragment {
    public var modifierTarget: Target { .paragraphs }

    public var text: FormattedText

    public static func read(using reader: inout Reader) -> Paragraph {
        return Paragraph(text: .read(using: &reader))
    }

    public func html(usingURLs urls: NamedURLCollection,
              modifiers: HTMLModifierCollection) -> String {
        let body = text.html(usingURLs: urls, modifiers: modifiers)
        return "<p>\(body)</p>"
    }

    public func plainText() -> String {
        text.plainText()
    }
    
    
    public func any(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> Any {
        return -1
    }
}

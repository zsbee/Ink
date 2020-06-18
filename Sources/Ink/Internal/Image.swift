/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public struct Image: Fragment {
    public var modifierTarget: Target { .images }

    public var link: Link

    public static func read(using reader: inout Reader) throws -> Image {
        try reader.read("!")
        return try Image(link: .read(using: &reader))
    }

    public func html(usingURLs urls: NamedURLCollection,
              modifiers: HTMLModifierCollection) -> String {
        let url = link.target.url(from: urls)
        var alt = link.text.html(usingURLs: urls, modifiers: modifiers)

        if !alt.isEmpty {
            alt = " alt=\"\(alt)\""
        }

        return "<img src=\"\(url)\"\(alt)/>"
    }

    public func plainText() -> String {
        link.plainText()
    }
    
    
    public func any(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> Any {
        return -1
    }
}

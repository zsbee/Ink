/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal struct Link: Fragment {
    var modifierTarget: Target { .links }

    var target: LTarget
    var text: FormattedText

    static func read(using reader: inout Reader) throws -> Link {
        try reader.read("[")
        let text = FormattedText.read(using: &reader, terminators: ["]"])
        try reader.read("]")

        guard !reader.didReachEnd else { throw Reader.Error() }

        if reader.currentCharacter == "(" {
            reader.advanceIndex()
            let url = try reader.read(until: ")")
            return Link(target: .url(url), text: text)
        } else {
            try reader.read("[")
            let reference = try reader.read(until: "]")
            return Link(target: .reference(reference), text: text)
        }
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: HTMLModifierCollection) -> String {
        let url = target.url(from: urls)
        let title = text.html(usingURLs: urls, modifiers: modifiers)
        return "<a href=\"\(url)\">\(title)</a>"
    }

    func plainText() -> String {
        text.plainText()
    }
    
    
    func any(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> Any {
        return -1
    }
}

extension Link {
    enum LTarget {
        case url(URL)
        case reference(Substring)
    }
}

extension Link.LTarget {
    func url(from urls: NamedURLCollection) -> URL {
        switch self {
        case .url(let url):
            return url
        case .reference(let name):
            return urls.url(named: name) ?? name
        }
    }
}

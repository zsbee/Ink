/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public struct HorizontalLine: Fragment {
    public var modifierTarget: Target { .horizontalLines }

    public static func read(using reader: inout Reader) throws -> HorizontalLine {
        guard reader.currentCharacter.isAny(of: ["-", "*"]) else {
            throw Reader.Error()
        }

        try require(reader.readCount(of: reader.currentCharacter) > 2)
        try require(reader.readUntilEndOfLine().isEmpty)
        return HorizontalLine()
    }

    public func html(usingURLs urls: NamedURLCollection,
              modifiers: HTMLModifierCollection) -> String {
        "<hr>"
    }

    public func plainText() -> String {
        // Since we want to strip all HTML from plain text output,
        // there is nothing to return here, just an empty string.
        ""
    }
    
    
    public func any(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> Any {
        return -1
    }
}

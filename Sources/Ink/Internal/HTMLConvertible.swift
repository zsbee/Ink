/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public protocol HTMLConvertible {
    func html(usingURLs urls: NamedURLCollection,
              modifiers: HTMLModifierCollection) -> String
}

extension HTMLConvertible where Self: HTMLModifiable {
    func html(usingURLs urls: NamedURLCollection,
              rawString: Substring,
              applyingModifiers modifiers: HTMLModifierCollection) -> String {
        var html = self.html(usingURLs: urls, modifiers: modifiers)

        modifiers.applyModifiers(for: modifierTarget) { modifier in
            html = modifier.closure((html, rawString))
        }

        return html
    }
}

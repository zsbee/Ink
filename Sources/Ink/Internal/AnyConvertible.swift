//
//  File.swift
//  
//
//  Created by Zsombor Fuszenecker on 2020. 06. 11..
//

import Foundation


public protocol AnyConvertible {
    func any(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> Any
}

extension AnyConvertible where Self: AnyModifiable {
    func any(usingURLs urls: NamedURLCollection,
              rawString: Substring,
              applyingModifiers modifiers: ModifierCollection) -> Any {
        var any = self.any(usingURLs: urls, modifiers: modifiers)

        modifiers.applyModifiers(for: modifierTarget) { modifier in
            any = modifier.closure(self as! Fragment)
        }

        return any
    }
}

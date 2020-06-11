//
//  File.swift
//  
//
//  Created by Zsombor Fuszenecker on 2020. 06. 11..
//

import Foundation

public struct ModifierCollection {
    private var modifiers: [Target : [Modifier]]

    init(modifiers: [Modifier]) {
        self.modifiers = Dictionary(grouping: modifiers, by: { $0.target })
    }

    func applyModifiers(for target: Target,
                        using closure: (Modifier) -> Void) {
        modifiers[target]?.forEach(closure)
    }

    mutating func insert(_ modifier: Modifier) {
        modifiers[modifier.target, default: []].append(modifier)
    }
}

/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal struct HTMLModifierCollection {
    private var modifiers: [Target : [HTMLModifier]]

    init(modifiers: [HTMLModifier]) {
        self.modifiers = Dictionary(grouping: modifiers, by: { $0.target })
    }

    func applyModifiers(for target: Target,
                        using closure: (HTMLModifier) -> Void) {
        modifiers[target]?.forEach(closure)
    }

    mutating func insert(_ modifier: HTMLModifier) {
        modifiers[modifier.target, default: []].append(modifier)
    }
}

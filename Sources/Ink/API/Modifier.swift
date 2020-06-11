//
//  Modifier.swift
//  
//
//  Created by Zsombor Fuszenecker on 2020. 06. 11..
//

import Foundation

public enum Target {
    case metadataKeys
    case metadataValues
    case blockquotes
    case codeBlocks
    case headings
    case horizontalLines
    case html
    case images
    case inlineCode
    case links
    case lists
    case paragraphs
    case tables
}

public struct Modifier {
    /// The type of input that each modifier is given, which both
    /// contains the HTML that was generated for a fragment, and
    /// its raw Markdown representation. Note that for metadata
    /// targets, the two input arguments will be equivalent.
    public typealias Input = Fragment
    /// The type of closure that Modifiers are based on. Each
    /// modifier is given a set of input, and is expected to return
    /// an HTML string after performing its modifications.
    public typealias Closure = (Input) -> Any

    /// The modifier's target, that defines what kind of fragment
    /// that it's used to modify. See `Target` for more info.
    public var target: Target
    /// The closure that makes up the modifier's body.
    public var closure: Closure

    /// Initialize an instance with the kind of target that the modifier
    /// should be used on, and a closure that makes up its body.
    public init(target: Target, closure: @escaping Closure) {
        self.target = target
        self.closure = closure
    }
}

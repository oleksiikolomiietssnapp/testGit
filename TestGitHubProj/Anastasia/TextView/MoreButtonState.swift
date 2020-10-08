//
//  MoreButtonState.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 02.10.2020.
//

enum MoreButtonState {
    case more
    case less
    
    var switchState: MoreButtonState {
        switch self {
        case .more:
            return MoreButtonState.less
        case .less:
            return MoreButtonState.more
        }
    }
    
    var title: String {
        switch self {
        case .more:
            return "More"
        case .less:
            return "Less"
        }
    }
}

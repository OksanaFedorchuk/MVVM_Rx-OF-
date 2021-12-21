//
//  ReposPersistency.swift
//  MVVM_Rx(OF)
//
//  Created by MacBook Air on 21.12.2021.
//

import Foundation
import UIKit

struct SavedRepos {
    static var savedRepos: [Repo] {
        get {
            guard let repos = UserDefaults.standard.array(forKey: "repos") as? [Data] else {return []}
            return repos.map { try! JSONDecoder().decode(Repo.self, from: $0) }
        }
        set {
            let data = newValue.map { try? JSONEncoder().encode($0)}
            UserDefaults.standard.setValue(data, forKey: "repos")
        }
    }
}

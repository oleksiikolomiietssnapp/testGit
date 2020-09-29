//
//  SvitlanaViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 27.09.2020.
//

import Foundation
import UIKit
import SafariServices


class SvitlanaViewController: UIViewController{
  
    @IBAction func webPageShowButton(_ sender: UIButton) {
        if let url = URL(string: "https://intita.com") {
            let vc = SFSafariViewController(url: url)
            vc.modalPresentationStyle = .popover
            present(vc, animated: true)
        }
    }
    
}

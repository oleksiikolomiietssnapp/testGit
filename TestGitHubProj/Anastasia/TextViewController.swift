//
//  TextViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 29.09.2020.
//

import UIKit

class TextViewController: UIViewController {
    let textView = UITextView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Netus et malesuada fames ac turpis egestas maecenas pharetra convallis. Consequat nisl vel pretium lectus quam id leo in vitae. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Maecenas ultricies mi eget mauris pharetra et ultrices neque. Morbi tincidunt augue interdum velit. Nunc non blandit massa enim nec dui nunc. Blandit aliquam etiam erat velit. Adipiscing commodo elit at imperdiet dui accumsan sit amet nulla. Cum sociis natoque penatibus et magnis dis. Scelerisque eu ultrices vitae auctor eu augue. Et tortor consequat id porta nibh venenatis. Enim nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Lectus urna duis convallis convallis tellus. Pretium fusce id velit ut tortor pretium viverra suspendisse. Vitae elementum curabitur vitae nunc sed velit. Fermentum et sollicitudin ac orci phasellus egestas. Vivamus arcu felis bibendum ut tristique et egestas. Elit duis tristique sollicitudin nibh sit amet commodo nulla facilisi. Aliquet risus feugiat in ante. Gravida quis blandit turpis cursus in hac habitasse platea dictumst. At tempor commodo ullamcorper a lacus vestibulum sed arcu non. Maecenas ultricies mi eget mauris pharetra et. Scelerisque in dictum non consectetur a. Id faucibus nisl tincidunt eget nullam non. A cras semper auctor neque vitae. Arcu vitae elementum curabitur vitae nunc sed velit. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Sit amet nisl suscipit adipiscing bibendum. Bibendum enim facilisis gravida neque convallis a cras. Urna nec tincidunt praesent semper feugiat. Sit amet porttitor eget dolor morbi non. A condimentum vitae sapien pellentesque. Ut etiam sit amet nisl purus in mollis nunc sed. Cras fermentum odio eu feugiat pretium. Amet justo donec enim diam vulputate ut pharetra. Duis convallis convallis tellus id interdum velit. Mauris cursus mattis molestie a iaculis at erat pellentesque adipiscing. Tincidunt lobortis feugiat vivamus at augue. Odio ut sem nulla pharetra diam sit. Tempus imperdiet nulla malesuada pellentesque elit eget gravida cum. Dolor purus non enim praesent elementum. Mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus. Id volutpat lacus laoreet non. Mattis enim ut tellus elementum sagittis vitae et. Enim sed faucibus turpis in. Volutpat lacus laoreet non curabitur gravida arcu ac tortor. Ipsum a arcu cursus vitae congue mauris rhoncus aenean vel. Sapien faucibus et molestie ac feugiat sed lectus vestibulum mattis. Sed faucibus turpis in eu mi bibendum neque."
        textView.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        let stack = UIStackView(arrangedSubviews: [textView, button])
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.backgroundColor = UIColor.white
        stack.frame = CGRect(x: 16, y: 24, width: view.bounds.maxX - 32, height: view.bounds.maxY - 64)
        button.frame = CGRect(x: 8, y: view.bounds.maxY - 32, width: 160, height: 64)
        button.setTitle("Learn more", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addSubview(stack)
    }
}
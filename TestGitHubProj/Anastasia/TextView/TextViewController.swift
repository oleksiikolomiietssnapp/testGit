//
//  TextViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 29.09.2020.
//

import UIKit

class TextViewController: UIViewController {
    lazy private var textView = { return UITextView() }()
    lazy private var showMoreBtn = { return UIButton() }()
    lazy private var scrollView = { return UIScrollView() }()
    lazy private var textField = { return UITextField() }()
    lazy private var saveBtn = {return UIButton() }()
    
    private let kOffset: CGFloat = 16
    private let kFontSize: CGFloat = 18
    private let kBtnHeight: CGFloat = 40
    
    private var moreButtonState = MoreButtonState.more
    
    private var safeAreaHeight: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.size.height
    }
    
    private var safeAreaWidth: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.size.width
    }
    
    private var safeAreaMinX: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.minX
    }
    
    private var safeAreaMinY: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.minY
    }
    
    private var maxLines: Int {
        let devider = kFontSize + 3.3
        return Int((safeAreaHeight - 5 * kOffset - 3 * kBtnHeight) / devider)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let navBar = UINavigationBar()
        view.addSubview(navBar)
        
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = false
        scrollView.addSubview(textView)
        scrollView.addSubview(showMoreBtn)
        scrollView.addSubview(textField)
        scrollView.addSubview(saveBtn)
        
        showMoreBtn.addTarget(self, action: #selector(switchScrollViewMode), for: UIControl.Event.touchUpInside)
        showMoreBtn.backgroundColor = UIColor.placeholderText
        showMoreBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        textField.font = textView.font
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder = "Input your text here."
        
        saveBtn.addTarget(self, action: #selector(appendTextToTextView), for: UIControl.Event.touchUpInside)
        saveBtn.backgroundColor = showMoreBtn.backgroundColor
        saveBtn.setTitle("Save", for: UIControl.State.normal)
        saveBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        textView.font = UIFont.systemFont(ofSize: kFontSize, weight: UIFont.Weight.light)
        textView.textAlignment = NSTextAlignment.justified
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        let filePath = Bundle.main.path(forResource: "text", ofType: "txt")
        guard let path = filePath,
              let text = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        else {
            return
        }
        textView.text = text
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customizeSubviews()
    }
    
    @objc private func switchScrollViewMode() {
        scrollView.isScrollEnabled.toggle()
        moreButtonState = moreButtonState.switchState
        customizeSubviews()
    }
    
    @objc private func appendTextToTextView() {
        guard let text = textField.text else {
            return
        }
        textView.text.append("\n\(text)")
        customizeSubviews()
        textField.text = nil
    }
    
    private func customizeSubviews() {
        textView.textContainer.maximumNumberOfLines = moreButtonState == MoreButtonState.more ? maxLines : 999999
        textView.frame = CGRect(x: kOffset, y: kOffset, width: safeAreaWidth - kOffset * 2, height: safeAreaHeight - kOffset * 2)
        textView.sizeToFit()
        
        scrollView.frame = CGRect(origin: CGPoint(x: safeAreaMinX, y: safeAreaMinY), size: view.safeAreaLayoutGuide.layoutFrame.size)
        scrollView.contentSize = CGSize(width: safeAreaWidth, height: textView.frame.height + 5 * kOffset + 3 * kBtnHeight)
        
        showMoreBtn.frame = CGRect(x: kOffset, y: textView.frame.maxY + kOffset, width: 140, height: kBtnHeight)
        showMoreBtn.setTitle(moreButtonState.title, for: UIControl.State.normal)
        
        textField.frame = CGRect(x: kOffset, y: showMoreBtn.frame.maxY + kOffset, width: safeAreaWidth - kOffset * 2, height: kBtnHeight)
        
        saveBtn.frame = CGRect(x: kOffset, y: textField.frame.maxY + kOffset, width: showMoreBtn.frame.width, height: kBtnHeight)
    }
}

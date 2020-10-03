//
//  ImageScrollView.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 01.10.2020.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {

    var imageZoomView: UIImageView?
    
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) -> Void {
        
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        
        self.delegate = self
        
        imageZoomView = UIImageView(image: image)
        
        guard let image = imageZoomView else { return }
        self.addSubview(image)
        
        configurateFor(imageSize: image.intrinsicContentSize)
    }
    
    func configurateFor(imageSize: CGSize) -> Void {
        self.contentSize = imageSize
        
        setCurrentMaxAndMinZoomScale()
        
        self.zoomScale = self.minimumZoomScale
        
        self.imageZoomView?.addGestureRecognizer(self.zoomingTap)
        self.imageZoomView?.isUserInteractionEnabled = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }
    
    func setCurrentMaxAndMinZoomScale() {
        
        let boundsSize = self.bounds.size
        guard let imageSize = imageZoomView?.bounds.size else { return }
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1
        
        if minScale < 0.1 { maxScale = 0.3 }
        if minScale >= 0.3 && minScale < 0.5 { maxScale = 0.7 }
        if minScale >= 0.5 { maxScale = max(1, minScale) }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale
        
    }
    
    func centerImage() {
        
        let boundsSize = self.bounds.size
        var frameToCenter = imageZoomView?.frame ?? CGRect.zero
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (bounds.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (bounds.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageZoomView?.frame = frameToCenter
        
//        print(imageZoomView?.frame.width, imageZoomView?.frame.height)
    }
    
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
        
        
    }
    
    func zoom(point: CGPoint, animated: Bool) -> Void {
        let currentScale = self.zoomScale
        let minScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) { return }
        
        let toScale = maxScale
        let finalScale = (currentScale == minScale) ? toScale : minScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        self.zoom(to: zoomRect, animated: animated)
    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        return zoomRect
    }
    
    
    
    //------
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }

}

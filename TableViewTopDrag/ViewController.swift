//
//  ViewController.swift
//  TableViewTopDrag
//
//  Created by Miguel Vieira on 27/11/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var imageHeight : CGFloat = 170;
    let originalImageHeight : CGFloat = 170;
    let minimumImageHeight : CGFloat = 70;
    var imageHeightConstraint : NSLayoutConstraint?;
    var oldScrollValue : CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: originalImageHeight);
        imageView.addConstraint(imageHeightConstraint!);
        tableView.contentOffset = CGPoint(x: 0, y: 0);
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!;
        
        cell.textLabel?.text = "I am cell number \(indexPath.row)";
        
        return cell;
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset = scrollView.contentOffset.y;
        
        let difference = oldScrollValue - yOffset;
        
        let tableViewTotalHeight = tableView.contentSize.height - tableView.frame.size.height;

        if (yOffset < 0 || yOffset > tableViewTotalHeight) { return }

        imageHeight += difference;
        
        if (imageHeight < minimumImageHeight)
        {
            imageHeight = minimumImageHeight;
        }
        else if (imageHeight > originalImageHeight)
        {
            imageHeight = originalImageHeight;
        }

        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2) {
            self.imageHeightConstraint?.constant = self.imageHeight;
            self.view.layoutIfNeeded()
        }
        
        oldScrollValue = yOffset;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
        SnapToPlace()
    }
    
    func SnapToPlace()
    {
        if (imageHeight < originalImageHeight/1.3)
        {
            imageHeight = minimumImageHeight;
        }
        else
        {
            imageHeight = originalImageHeight;
        }
    
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2) {
            self.imageHeightConstraint?.constant = self.imageHeight;
            self.view.layoutIfNeeded()
        }
    }

}


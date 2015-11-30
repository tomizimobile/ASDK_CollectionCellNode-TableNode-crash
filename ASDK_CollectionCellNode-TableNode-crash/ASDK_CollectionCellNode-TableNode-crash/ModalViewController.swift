//
//  ModalViewController.swift
//  ASDK_CollectionCellNode-TableNode-crash
//
//  Created by Tom King on 11/30/15.
//  Copyright © 2015 iZi Mobile. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ModalViewController: UIViewController, ASCollectionViewDataSource, ASCollectionViewDelegate
{
    var collectionView: ASCollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done:")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 11
        layout.minimumLineSpacing = 11
        layout.sectionInset.top = 11
        
        collectionView = ASCollectionView(frame: view.bounds, collectionViewLayout: layout, asyncDataFetching: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.lightGrayColor()
        collectionView.asyncDataSource = self
        collectionView.asyncDelegate = self
        view.addSubview(collectionView)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collectionView" : collectionView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collectionView" : collectionView]))
    }
    
    func done(sender: UIBarButtonItem)
    {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode!
    {
        return Node()
    }
}

class Node: ASCellNode, ASTableViewDataSource, ASTableViewDelegate
{
    var title: ASTextNode!
    var tableNode: ASTableNode!
    
    override init!()
    {
        super.init()
        backgroundColor = UIColor.whiteColor()
        
        title = ASTextNode()
        title.layerBacked = true
        title.attributedString = NSAttributedString(string: "Title", attributes: [NSFontAttributeName : UIFont.boldSystemFontOfSize(17), NSForegroundColorAttributeName : UIColor.blackColor()])
        addSubnode(title)
        
        tableNode = ASTableNode(style: .Plain)
        addSubnode(tableNode)
    }
    
    override func didLoad()
    {
        super.didLoad()
        
        tableNode.view.asyncDataSource = self
        tableNode.view.asyncDelegate = self
        tableNode.view.rowHeight = 52
        setNeedsLayout()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec!
    {
        let insetTitle = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 11, 0, 11), child: title)
        let topSpacer = ASLayoutSpec()
        topSpacer.flexGrow = true
        let bottomSpacer = ASLayoutSpec()
        bottomSpacer.flexGrow = true
        let titleStack = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Center, alignItems: .Start, children: [topSpacer, insetTitle, bottomSpacer])
        titleStack.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1), ASRelativeDimensionMakeWithPoints(52))
        
        var children: [ASLayoutable] = [ASStaticLayoutSpec(children: [titleStack])]
        if tableNode.nodeLoaded
        {
            tableNode.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1), ASRelativeDimensionMakeWithPoints(CGFloat(tableView(tableNode.view, numberOfRowsInSection: 0))*tableNode.view.rowHeight))
            children.append(ASStaticLayoutSpec(children: [tableNode]))
        }
        else
        {
            children.append(tableNode)
        }
        let stack = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Center, alignItems: .Start, children: children)
        
        let maxWidth = ASRelativeDimensionMakeWithPoints(constrainedSize.max.width-2*11)
        let minSize = ASRelativeSize(width: maxWidth, height: ASRelativeDimensionMakeWithPercent(0))
        let maxSize = ASRelativeSizeMake(maxWidth, ASRelativeDimensionMakeWithPercent(1))
        stack.sizeRange = ASRelativeSizeRangeMake(minSize, maxSize)
        return ASStaticLayoutSpec(children: [stack])
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode!
    {
        return TableNode()
    }
}

class TableNode: ASCellNode
{
    var title: ASTextNode!
    var subtitle: ASTextNode!
    
    override init!()
    {
        super.init()
        
        title = ASTextNode()
        title.layerBacked = true
        title.flexShrink = true
        title.maximumLineCount = 1
        title.truncationMode = .ByTruncatingTail
        title.attributedString = NSAttributedString(string: "Title", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15), NSForegroundColorAttributeName : UIColor.blackColor()])
        addSubnode(title)
        
        subtitle = ASTextNode()
        subtitle.layerBacked = true
        subtitle.flexShrink = true
        subtitle.maximumLineCount = 1
        subtitle.truncationMode = .ByTruncatingTail
        subtitle.attributedString = NSAttributedString(string: "Subtitle", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(13), NSForegroundColorAttributeName : UIColor.darkGrayColor()])
        addSubnode(subtitle)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec!
    {
        let labelStack = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Center, alignItems: .Start, children: [title, subtitle])
        labelStack.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1), ASRelativeDimensionMakeWithPoints(52))
        return ASStaticLayoutSpec(children: [labelStack])
    }
}

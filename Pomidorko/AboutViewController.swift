//
//  AboutViewController.swift
//  Pomidorko
//
//  Created by Volter on 28.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa
import WebKit

class AboutViewController: NSViewController, WebPolicyDelegate, WebUIDelegate
{
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        let webView = WebView(
            frame: NSMakeRect(
                0,  0,
                view.frame.width,
                view.frame.height - 18
            ),
            frameName: "Frame",
            groupName: "Group"
        )
        
        let path = NSBundle.mainBundle().pathForResource(
            localeString("about-page"), ofType: "html"
        )
        let url = NSURL(fileURLWithPath: path!)
        let request = NSURLRequest(URL: url)
        
        webView.mainFrame.loadRequest(request)
        
        webView.policyDelegate = self
        webView.UIDelegate = self
        webView.editingDelegate = self
        
        view.addSubview(webView)
        
        flatify(view.window!, color: WhiteColor)
    }
    
    /** 
     * WebView disabling shit 
     * 
     * I hate those long method definitions
     */
    
    func webView(
        webView:                                            WebView!,
        decidePolicyForNavigationAction actionInformation: [NSObject : AnyObject]!,
        request:                                            NSURLRequest!,
        frame:                                              WebFrame!,
        decisionListener listener:                          WebPolicyDecisionListener!
    ) {
        if (request.URL?.host != nil) {
            NSWorkspace.sharedWorkspace().openURL(request.URL!)
        }
        else {
            listener.use()
        }
    }
    
    func webView(
        sender:                              WebView!,
        contextMenuItemsForElement element: [NSObject : AnyObject]!,
        defaultMenuItems:                   [AnyObject]!) -> [AnyObject]!
    {
        return nil
    }
    
    override func webView(
        webView:                                   WebView!,
        shouldChangeSelectedDOMRange currentRange: DOMRange!,
        toDOMRange proposedRange:                  DOMRange!,
        affinity selectionAffinity:                NSSelectionAffinity,
        stillSelecting flag:                       Bool
    ) -> Bool {
        return false
    }
    
    func webView(
        webView:                            WebView!,
        dragSourceActionMaskForPoint point: NSPoint) -> Int
    {
        return 0
    }
    
    func webView(
        webView:                                               WebView!,
        dragDestinationActionMaskForDraggingInfo draggingInfo: NSDraggingInfo!) -> Int
    {
        return 0
    }
}

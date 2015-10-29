//
//  AboutViewController.swift
//  Pomidorko
//
//  Created by Volter on 28.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa
import WebKit

class AboutViewController: NSViewController, WebPolicyDelegate
{
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        let view: NSView? = self.view
        
        let webView = WebView(
            frame: (view?.frame)!,
            frameName: "Frame",
            groupName: "Group"
        )
        
        let path = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        let url = NSURL(fileURLWithPath: path!)
        let request = NSURLRequest(URL: url)
        
        webView.mainFrame.loadRequest(request)
        webView.policyDelegate = self
        
        view?.addSubview(webView)
        view?.window?.backgroundColor = WhiteColor
    }
    
    /**
     * From stack overflow
     */
    func webView(
        webView: WebView!,
        decidePolicyForNavigationAction actionInformation: [NSObject : AnyObject]!,
        request: NSURLRequest!,
        frame: WebFrame!,
        decisionListener listener: WebPolicyDecisionListener!
    ) {
        if (request.URL?.host != nil) {
            NSWorkspace.sharedWorkspace().openURL(request.URL!)
        }
        else {
            listener.use()
        }
    }
}

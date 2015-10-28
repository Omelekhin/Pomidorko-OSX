//
//  AboutViewController.swift
//  Pomidorko
//
//  Created by Volter on 28.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa
import WebKit

class AboutViewController: NSViewController
{
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        let view: NSView? = self.view
        
        var webView = WebView(
            frame: (view?.frame)!,
            frameName: "Frame",
            groupName: "Group"
        )
        
        var path = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        var url = NSURL(fileURLWithPath: path!)
        var request = NSURLRequest(URL: url!)
        
        webView.mainFrame.loadRequest(request)
        webView.policyDelegate = self
        
        view?.addSubview(webView)
        view?.window?.backgroundColor = WhiteColor
    }
    
    override func webView(
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

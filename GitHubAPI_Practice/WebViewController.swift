//
//  WebViewController.swift
//  GitHubAPI_Practice
//
//  Created by daiki umehara on 2021/06/07.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    private var url: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = url else {
            dismiss(animated: true, completion: nil)
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    static func instantiate(url: String) -> WebViewController {
        let webVC = UIStoryboard.init(name: "WebView", bundle: nil).instantiateInitialViewController() as! WebViewController
        webVC.url = URL(string: url)
        return webVC
    }
    
}

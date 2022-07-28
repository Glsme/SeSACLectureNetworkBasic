//
//  WebViewController.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com"
    
    //App Transport Scurity Settings
    //http X
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(url: destinationURL)
        searchBar.delegate = self
    }
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
//        openWebPage(url: self.nowURL)
    }
    
    @IBAction func goFowardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let url = searchBar.text else { return }
        openWebPage(url: url)
    }
}

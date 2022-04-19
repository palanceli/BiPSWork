//
//  Ch23WebViewController.swift
//  BiPSWork
//
//  Created by palance on 2022/4/19.
//

import UIKit
import WebKit

class Ch23WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var targetURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // 用webview打开URL
        if let url = URL(string: targetURL){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

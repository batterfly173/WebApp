import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBAction func backButtonAction(_ sender: Any)
    {
        if webView.canGoBack
        {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: Any)
    {
        if webView.canGoForward
        {
            webView.goForward()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        backButton.isEnabled = true
        forwardButton.isEnabled = true
        
        searchTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        
        searchTextField.text = homePage
        let url = URL(string: homePage)
        let rerquest = URLRequest(url: url!)
        
        webView.load(rerquest)
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        let urlString = searchTextField.text
        let url = URL(string: urlString!)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        searchTextField.text = webView.url?.absoluteString
        
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}


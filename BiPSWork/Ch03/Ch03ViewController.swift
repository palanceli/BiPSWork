//
//  Ch03ViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/5.
//

import UIKit

class Ch03ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMessage(sender: UIButton){
        let hitButton = sender
        if let buttonText = hitButton.titleLabel?.text{
            let strMsg = "Hello World " + buttonText
            let alertController = UIAlertController(title: "Welcome to My first App", message: strMsg, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alertController, animated: true)
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

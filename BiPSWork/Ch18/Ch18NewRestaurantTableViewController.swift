//
//  Ch18NewRestaurantTableViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/17.
//

import UIKit

class Ch18NewRestaurantTableViewController: UITableViewController {
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 10.0
            photoImageView.layer.masksToBounds = true
            
        }
    }
    
    // ① 依次设置焦点顺序
    @IBOutlet var nameTextField: Ch18RoundedTextField!{
      didSet{
        nameTextField.tag = 1  // 设置焦点顺序
        nameTextField.becomeFirstResponder() // 将name设置为first responder
        nameTextField.delegate = self
      }
    }

    @IBOutlet var typeTextField: Ch18RoundedTextField!{
      didSet{
        typeTextField.tag = 2
        typeTextField.delegate = self
      }
    }
    
    @IBOutlet var addressTextField: Ch18RoundedTextField!{
      didSet{
        addressTextField.tag = 3
        addressTextField.delegate = self
      }
    }
    
    @IBOutlet var phoneTextField: Ch18RoundedTextField!{
      didSet{
        phoneTextField.tag = 4
        phoneTextField.delegate = self
      }
    }
    
    @IBOutlet var descriptionTextView: UITextView!{
      didSet{
        descriptionTextView.tag = 5
        descriptionTextView.layer.cornerRadius = 10.0
        descriptionTextView.layer.masksToBounds = true
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 当用户点击ImageView的任何区域，都关闭键盘
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {   // 点击首行单元格
            // 定义提示窗，选择照片
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            // 定义行动点，触发拍照
            let cameraAction = UIAlertAction(title: "使用相机", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self  // 拍摄完成后，由self接收
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            // 定义行动点，触发相册
            let photoLibraryAction = UIAlertAction(title: "选择相册", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self  // 选中图片后，由self接收
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            // 添加行动点
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            // 弹出提示窗
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// 扩展UITextFieldDelegate协议，当点击回车键，移动焦点
extension Ch18NewRestaurantTableViewController: UITextFieldDelegate{
  // 当点击回车键
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // 获取下一个输入焦点
    if let nextTextField = view.viewWithTag(textField.tag + 1) {
      textField.resignFirstResponder()     // 释放first responder
      nextTextField.becomeFirstResponder() // 成为first responder
    }
    return true
  }
}

// 接收相机、相册选择图片
extension Ch18NewRestaurantTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // 获取被选中的图片
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }

        dismiss(animated: true, completion: nil)
    }
    
}

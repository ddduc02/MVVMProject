//
//  EditProfileViewController.swift
//  MVVMProject
//
//  Created by ducdo on 22/01/2024.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    var user: User?
    var userImage : UIImage?
    var editprofileViewModel: EditProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = user else {
            return
        }
        editprofileViewModel = EditProfileViewModel(user: user)
        setupUI()

    }
    
    @IBAction func onTapEdit(_ sender: UIButton) {
        showImageGalary()
    }
    
    @IBAction func onTapDone(_ sender: UIButton) {
        editprofileViewModel.user.value.name = nameField.text ?? ""
        editprofileViewModel.user.value.email = emailField.text ?? ""
        editprofileViewModel.user.value.phone = phoneField.text ?? ""
        editprofileViewModel.uesrImage = avatarImage.image
        editprofileViewModel.updateInfor(user: editprofileViewModel.user.value) { [weak self] success in
            if success {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setupUI() {
        navigationItem.title = "Edit profile"
        avatarView.round()
        guard let user = self.user else {
            return
        }
        nameField.text = user.name
        emailField.text = user.email
        phoneField.text = user.phone
        
        if let userImage = userImage {
            avatarImage.image = userImage
        }
    }
    
    func showImageGalary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension EditProfileViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            avatarImage.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//
//  CommentsViewController.swift
//  Instagram
//
//  Created by 内藤有紀 on 2022/05/31.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentsViewController: UIViewController {
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendcomment: UIButton!
    var postData: PostData!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleSendCommentButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        let name = Auth.auth().currentUser?.displayName
        let comment = commentTextField.text!
        let today = Date()
        let dateFormatter = DateFormatter()

        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))

        print(dateFormatter.string(from: today))
        var commentData: [String: Any] = [:]
        commentData["name"] = "内藤有紀"
        commentData["comment"] = comment
        commentData["date"] = dateFormatter.string(from: today)
        print("ドキュメント：")
        print(postData.id)
        // 更新データを作成する
        var updateValue: FieldValue
        // 今回新たにいいねを押した場合は、myidを追加する更新データを作成
        updateValue = FieldValue.arrayUnion([commentData])
        // commentsに更新データを書き込む
        postRef.updateData(["comments": updateValue])
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
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

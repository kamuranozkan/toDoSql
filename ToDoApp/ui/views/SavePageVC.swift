
import UIKit

class SavePageVC: UIViewController {

    var viewModel = SavePageViewModel()
    
    @IBOutlet weak var toDoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func saveButtonAct(_ sender: Any) {
        if let todo_name = toDoTextField.text{
            viewModel.save(todo_name: todo_name)
        }
       
    }
}

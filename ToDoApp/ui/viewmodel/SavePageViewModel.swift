
import Foundation

class SavePageViewModel{
    
    var trepo = TodoDaoRepository()
    
    func save (todo_name: String){
        trepo.save(todo_name: todo_name)
    }
}

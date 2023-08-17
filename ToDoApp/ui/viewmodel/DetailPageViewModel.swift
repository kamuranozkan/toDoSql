

import Foundation

class DetailPageViewModel{
    
    var trepo = TodoDaoRepository()
    
    func update (todo_id: Int, todo_name: String){
        trepo.update(todo_id: todo_id, todo_name: todo_name)
    }
}

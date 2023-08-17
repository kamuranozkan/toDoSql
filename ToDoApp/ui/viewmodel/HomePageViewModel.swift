import Foundation
import RxSwift

class HomePageViewModel {
    
    var trepo = TodoDaoRepository()
    var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    init() {
        copyDatabase()
        todoList = trepo.todoList
    }
    
    func delete(todo_id: Int) {
        trepo.delete(todo_id: todo_id)
        uploadTodo()
    }
    
    func search(searchWord: String) {
        trepo.search(searchWord: searchWord)
    }
    
    func uploadTodo() {
        trepo.uploadTodo()
    }
    
    func copyDatabase() {
        guard let bundlePath = Bundle.main.path(forResource: "todo", ofType: ".sqlite") else {
            print("Error finding the database in the bundle.")
            return
        }
        
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: filePath).appendingPathComponent("todo.sqlite")
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: dbURL.path) {
            print("File already exists")
        } else {
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: dbURL.path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

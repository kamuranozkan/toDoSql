import Foundation
import RxSwift

class TodoDaoRepository {
    
    public var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    public let db: FMDatabase?
    
    init(){
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: filePath).appendingPathComponent("todo.sqlite")
        db = FMDatabase(path: dbURL.path)
    }
    
    func save(todo_name: String) {
        executeUpdate("INSERT INTO todos (todo_name) VALUES (?)", values: [todo_name])
    }
    
    func update(todo_id: Int, todo_name: String) {
        executeUpdate("UPDATE todos SET todo_name = ? WHERE todo_id = ?", values: [todo_name, todo_id])
    }
    
    func delete(todo_id: Int) {
        executeUpdate("DELETE FROM todos WHERE todo_id = ?", values: [todo_id])
    }
    
    func search(searchWord: String) {
        let todos = fetchTodos("SELECT * FROM todos WHERE todo_name like ?", values: ["%\(searchWord)%"])
        todoList.onNext(todos)
    }
    
    func uploadTodo() {
        let todos = fetchTodos("SELECT * FROM todos", values: nil)
        todoList.onNext(todos)
    }
    
    private func executeUpdate(_ sql: String, values: [Any]) {
        db?.open()
        do {
            try db?.executeUpdate(sql, values: values)
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    public func fetchTodos(_ sql: String, values: [Any]?) -> [Todo] {
        db?.open()
        var list = [Todo]()
        do {
            let result = try db?.executeQuery(sql, values: values)
            while result?.next() ?? false {
                if let todo_idString = result?.string(forColumn: "todo_id"),
                   let todo_id = Int(todo_idString),
                   let todo_name = result?.string(forColumn: "todo_name") {
                    list.append(Todo(todo_id: todo_id, todo_name: todo_name))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }

}

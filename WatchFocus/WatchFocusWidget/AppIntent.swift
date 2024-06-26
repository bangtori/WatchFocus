//
//  AppIntent.swift
//  WatchFocusWidget
//
//  Created by 방유빈 on 2024/02/28.
//

import WidgetKit
import AppIntents
import RealmSwift

struct WidgetCategory: AppEntity {
    let id: String
    let category: Category?
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Category"
    static var defaultQuery: CategoryQuery = CategoryQuery()
    static var defaultsAllCategory =  WidgetCategory(id: "ALL", category: nil)
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(category?.name ?? "ALL")")
    }
    
    
    static var allCategoies: [WidgetCategory] = [
        defaultsAllCategory
    ]
}

struct CategoryQuery: EntityQuery {
    func entities(for identifiers: [WidgetCategory.ID]) async throws -> [WidgetCategory] {
        WidgetCategory.allCategoies.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [WidgetCategory] {
        let decoder:JSONDecoder = JSONDecoder()
        var newWidgetCategorys = [
            WidgetCategory.defaultsAllCategory
        ]
        if let data = UserDefaults.groupShared.object(forKey: UserDefaultsKeys.categorys.rawValue) as? Data {
            if let categorys = try? decoder.decode([Category].self, from: data){
                categorys.forEach { category in
                    newWidgetCategorys.append(WidgetCategory(id: UUID().uuidString, category: category))
                }
            }
        }
        WidgetCategory.allCategoies = newWidgetCategorys
        return WidgetCategory.allCategoies
    }
    
    func defaultResult() -> WidgetCategory? {
        WidgetCategory.allCategoies.first
    }
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "카테고리 선택"
    static var description = IntentDescription("표시할 Todo의 카테고리를 선택해 주세요.")
    
    @Parameter(title: "카테고리 선택")
    var widgetCategory: WidgetCategory
    
    init(category: WidgetCategory) {
        self.widgetCategory = category
    }
    
    
    init() {}
}

struct CheckTodoIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Check Todo"
    
    @Parameter(title: "Todo Id")
    var todoId: String
    
    init(todoId: String) {
        self.todoId = todoId
    }
    init() {}
    
    @MainActor func perform() async throws -> some IntentResult {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.watchFocus")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
        do {
            let objectId = try ObjectId(string: todoId)
            let realm = try await Realm(configuration: config)
            let todo = realm.object(ofType: TodoObject.self, forPrimaryKey: objectId)
            
            try realm.write {
                if let todo = todo {
                    todo.isChecked.toggle()
                    realm.add(todo, update: .modified)
                }
            }
        } catch {
            print("Realm 불러오기 실패 : \(error.localizedDescription)")
        }
        return .result()
    }
}

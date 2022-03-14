//
//  Category.swift
//  ToDoList
//
//  Created by Inna Kokorina on 11.03.2022.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items = List<Item>()
    @Persisted var cellColor: String = ""
}

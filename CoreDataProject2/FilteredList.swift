//
//  FilteredList.swift
//  CoreDataProject2
//
//  Created by Brandon Knox on 4/26/21.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    enum PredicateType: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case containsCI = "CONTAINS[c]"
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], predicateType: PredicateType,
         @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors,
                                       predicate: NSPredicate(format: "%K \(predicateType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}


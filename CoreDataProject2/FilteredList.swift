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
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], predicateType: String,
         @ViewBuilder content: @escaping (T) -> Content) {
//        Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate.
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors,
                                       predicate: NSPredicate(format: "%K \(predicateType) %@", filterKey, filterValue))
        self.content = content
    }
}


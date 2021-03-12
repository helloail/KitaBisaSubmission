//
//  CoreDataHelper.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 12/03/21.
//

import Foundation
import CoreData

class CoreDataHelper {
    lazy var persistentconteiner: NSPersistentContainer = {
        let persistentconteiner  = NSPersistentContainer(name: "KitaBisaSubmission")
        persistentconteiner.loadPersistentStores { _, _ in
            
        }
        return persistentconteiner
    }()
    
    var moc: NSManagedObjectContext {
        persistentconteiner.viewContext
    }
}

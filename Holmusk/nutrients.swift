//
//  nutrients.swift
//  Holmusk
//
//  Created by Vinupriya on 7/31/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit
import Realm

class nutrients: RLMObject {
    dynamic var name = ""
    dynamic var content = RLMArray(objectClassName: contents.className())
}

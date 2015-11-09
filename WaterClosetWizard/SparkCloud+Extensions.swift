//  SparkCloud+Extensions.swift
//  WaterClosetWizard
//  Created by Chris Nielubowicz on 11/9/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.

import Foundation

extension SparkCloud {
    
    func subscribeToAllEventsWithEventPrefix(eventPrefix: EventPrefix, handler: SparkEventHandler) {
        subscribeToAllEventsWithPrefix(eventPrefix.rawValue, handler: handler)
    }
}
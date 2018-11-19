//
//  DownloadManager.swift
//  DownloadManager
//
//  Created by ivan_man-kit-cheung on 11/17/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation

typealias CompletionHandler = () -> (Void)

protocol TaskManaging {
  init(maxConcurrentTasks: Int)

  func queueTask(task: Task, completionHandler: CompletionHandler)
//  var concurrentTasks: Int { get set }
}

typealias Task = () -> ()

class TaskManager: TaskManaging {
  var pendingQueue: [Task] = []

  var currentlyProcessingTasks: [Task] = []

  private let maxConcurrentTasks: Int

  required init(maxConcurrentTasks: Int) {
    self.maxConcurrentTasks = maxConcurrentTasks
  }

  func queueTask(task: () -> (), completionHandler: () -> (Void)) {
    pendingQueue
      .append {

      }
  }

  func cancelTask(task: Task) {

  }
}

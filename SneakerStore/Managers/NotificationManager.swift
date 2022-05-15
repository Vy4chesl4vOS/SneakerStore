//
//  NotificationManager.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 13.05.2022.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestAuth () {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { sucess, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Success")
            }
        }
    }
    
    func sendDeliveryNotification () {
        let content = UNMutableNotificationContent()
        content.title = "Sucess order"
        content.subtitle = "Your sneakers in work"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func sendEveryMonthNotification () {
        let content = UNMutableNotificationContent()
        content.title = "SneakerStore"
        content.subtitle = "It's time to update your sneakers"
        content.sound = .default
    
        var dataComopents = DateComponents()
        dataComopents.month = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComopents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

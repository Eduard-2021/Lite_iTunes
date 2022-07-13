//
//  ConvertDate.swift
//  Lite_iTunes
//
//  Created by Eduard on 29.08.2021.
//

import UIKit

final class ConvertDate {
    
    static func ConvertDateFuncForSongs(releaseDate: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
//        let dateCreateSong = dateFormatter.date(from: releaseDate)
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
        ]
        if let fullDateCreateSong = isoDateFormatter.date(from: releaseDate) {
            let fullDateCreateSongInString = "\(fullDateCreateSong)"
            return String(fullDateCreateSongInString.prefix(10))
        }
        else {return ""}
        
    }
    
    static func ConvertDateFuncForWhatsNew(releaseDate: String) -> String {
    let oneDayInSeconds: Double = 60*60*24
    let oneMonthInSeconds: Double = 60*60*24*30
    let oneYearInSeconds: Double = 60*60*24*30*12

    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    isoDateFormatter.formatOptions = [
        .withFullDate,
    //    .withFullTime,
    //    .withDashSeparatorInDate,
    //    .withFractionalSeconds
    ]

    if let realDate = isoDateFormatter.date(from: releaseDate) {
            let timeIntervalSinceNow = realDate.timeIntervalSinceNow
            let numberDays = abs(timeIntervalSinceNow/oneDayInSeconds)
            let roundNumberDays = Int(round(numberDays))
            switch numberDays {
            case 0..<1:
                return "сегодня"
            case 1..<2, 20..<21, 30..<31:
                return "\(roundNumberDays) день назад"
            case 2..<4, 21..<24:
                return "\(roundNumberDays) дня назад"
            case 5..<21, 24..<30:
                return "\(roundNumberDays) дней назад"
            case 31..<365:
                let numberMonths = abs(timeIntervalSinceNow/oneMonthInSeconds)
                let roundNumberMonths = Int(round(numberMonths))
                switch numberMonths {
                case 1..<2:
                    return "\(roundNumberMonths) месяц назад"
                case 2..<4:
                    return "\(roundNumberMonths) месяца назад"
                case 5...12:
                    return "\(roundNumberMonths) месяцeв назад"
                default:
                    return "\(roundNumberMonths) месяцeв назад"
                }
            default:
                let numberYears = abs(timeIntervalSinceNow/oneYearInSeconds)
                let roundNumberYears = Int(round(numberYears))
                switch numberYears {
                case 1..<2:
                    return "\(roundNumberYears) год назад"
                case 2..<4:
                    return "\(roundNumberYears) года назад"
                case 5..<21:
                    return "\(roundNumberYears) лет назад"
                default:
                    return "\(roundNumberYears) лет назад"
                }
            }
        }
        return ""
    }
}


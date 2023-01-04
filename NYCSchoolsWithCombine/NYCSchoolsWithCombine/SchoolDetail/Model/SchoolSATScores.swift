//
//  SchoolSATScores.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation

struct SchoolSATScores: Decodable {
    
    let dbn: String
    let schoolName: String
    let readingScore: String
    let mathScore: String
    let writingScore: String

    enum CodingKeys: String, CodingKey {
        case readingScore = "satCriticalReadingAvgScore"
        case mathScore = "satMathAvgScore"
        case writingScore = "satWritingAvgScore"
        case dbn, schoolName
    }
    
}

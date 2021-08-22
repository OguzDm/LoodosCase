//
//  MovieDetailModel.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 22.08.2021.
//

import Foundation

struct MovieDetailModel: Decodable {
    
    let Title: String
    let Year: String
    let Runtime: String
    let Genre: String
    let Plot: String
    let Language: String
    let Poster: String
    let imdbID : String
    let imdbRating: String
    var dictionary: [String: String] {
        return ["Title":Title,
                "Year":Year,
                "Runtime":Runtime,
                "Genre":Genre,
                "Plot":Plot,
                "Language":Language,
                "Poster":Poster,
                "imdbID":imdbID]
    }
    
    var runtime: String {
        let digits = Runtime.split(separator: " ")
        
        return String(digits[0])
    }
    
    var language: String{
        if Language.contains(",") {
            let language = Language.split(separator: ",")
            return String(language[0])
        }
        else {
         return Language
        }
    }
}

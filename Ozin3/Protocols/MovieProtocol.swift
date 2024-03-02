//
//  MovieProtocol.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 11.02.2024.
//

import Foundation
protocol MovieProtocol: AnyObject {
    func movieDidSelect(movie: Movie)
    func ageDidSelect(id: Int, name: String)
    func genreDidSelect(id: Int, name: String)
}

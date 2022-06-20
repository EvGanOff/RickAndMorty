//
//  RMErrors.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import Foundation

enum RMErrors: String, Error {
    case unableToComplete = "Не удается обработать ваш запрос. Пожалуйста, проверьте ваше интернет-соединение."
    case invalidResponce = "Ошибка соединения. Пожалуйста, попробуйте еще раз."
    case invalidData = "Данные, полученные с сервера, недействительны. Пожалуйста, попробуйте еще раз."
}



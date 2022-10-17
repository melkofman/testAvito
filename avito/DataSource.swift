//
//  Services.swift
//  avito
//
//  Created by Melanie Kofman on 17.10.2022.
//

import Foundation
struct DataList: Decodable {
    let company: CompanyInfo
}

struct CompanyInfo: Decodable {
    let name: String
    let employees: [EmployeeInfo]
}

struct EmployeeInfo: Decodable {
    let name: String
    let phone_number: String
    let skills: [String]
}

class DataSource {
    private var onUpdate: ((DataList)->Void)?
    private var isUpdating = false
    
    func setOnUpdate(onUpdate: @escaping (DataList)->Void) {
        self.onUpdate = onUpdate
    }
    
    func setUpUpdate() {
        guard !isUpdating else {
            return
        }
        loadInfo()
    }
    
    private func loadInfo() {
        print("use api")
        let session = URLSession.shared
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            print("wong url")
            return
        }
        let dataTask = session.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, let parsedData = try? JSONDecoder().decode(DataList.self, from: data) else {
                print("parse error")
                return
            }
            print("parsed")
            print(parsedData)
            
            self.onUpdate?(parsedData)
        })
        dataTask.resume()
        
    }
    
}

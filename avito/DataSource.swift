//
//  Services.swift
//  avito
//
//  Created by Melanie Kofman on 17.10.2022.
//

import Foundation
struct DataList: Decodable {
    var company: CompanyInfo
}

struct CompanyInfo: Decodable {
    let name: String
    var employees: [EmployeeInfo]
}

struct EmployeeInfo: Decodable {
    let name: String
    let phone_number: String
    let skills: [String]
}

class DataSource {
    private let cache = Cache<String, DataList>()
    
    private var onUpdate: ((DataList)->Void)?
    private var isUpdating = false
    
    private var setToast: ((String)->Void)?
    
    func setOnUpdate(onUpdate: @escaping (DataList)->Void) {
        self.onUpdate = onUpdate
    }
    
    func setUpUpdate() {
        guard !isUpdating else {
            return
        }
        loadInfo()
        //           MARK: remove
        checkCache()
    }
    
    func showToast(setToast: @escaping (String)->Void) {
        self.setToast = setToast
    }
    
    private func loadInfo() {
        let session = URLSession.shared
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            print("wong url")
            return
        }
        let dataTask = session.dataTask(with: url, completionHandler: {data, response, error in
            if let error = error as NSError? {
                if error.code != 200 {
                    print("Error server force toast")
                    self.setToast?("Че-то с сервером")
                }
            }
            guard let data = data, var parsedData = try? JSONDecoder().decode(DataList.self, from: data) else {return}
            
            parsedData.company.employees.sort {
                $0.name < $1.name
            }
            
            print("parsed")
            print(parsedData)
//            self.cache.insert(value: parsedData, forKey: parsedData.company.name)
            //           MARK: remove
            self.checkCache()
            self.onUpdate?(parsedData)
        })
        dataTask.resume()
    }
    //           MARK: remove
    private func checkCache() {
        print("check cache")
        print(self.cache.value(forKey: "Avito") ?? "")
    }
}

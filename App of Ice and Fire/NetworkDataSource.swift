//
//  NetworkDataSource.swift
//  App of Ice and Fire
//
//  Created by iOS Student on 2021. 11. 04..
//

import Foundation

class NetworkDataSource : AnApiOfIceAndFireAPI {
    
    // MARK: - Properties
    
    private var urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    static let BASE_URL = "https://www.anapioficeandfire.com/api"
    static let SHORT_URL = "https://anapioficeandfire.com/api"
    static let BOOKS_URL = "/books/"
    static let CHARACTERS_URL = "/characters/"
    static let HOUSES_URL = "/houses/"
    
    private let regex = try! NSRegularExpression(pattern: "page=[0-9]+&")
    
    func getBooks(atPage page: Int, completionCallback: @escaping ([NetworkBookModel]) -> Void) {
        urlSession.dataTask(with: URLComponents.generateUrl(forPath: .books, withPage: page)) { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let books = try decoder.decode([NetworkBookModel].self, from: data)
                    completionCallback(books)
                } catch let exception {
                    print(exception)
                }
            }
        }.resume()
    }
    
    func getCharacters(atPage page: Int, completionCallback: @escaping ([NetworkCharacterModel], Int) -> Void) {
        urlSession.dataTask(with: URLComponents.generateUrl(forPath: .characters, withPage: page)) { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data, let response = response as? HTTPURLResponse {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let characters = try decoder.decode([NetworkCharacterModel].self, from: data)
                    let lastPage = self.extractLastPageFromHeader(response.allHeaderFields["Link"] as! String)
                    completionCallback(characters, lastPage)
                } catch let exception {
                    print(exception)
                }
            }
        }.resume()
    }
    
    func getHouses(atPage page: Int, completionCallback: @escaping ([NetworkHouseModel], Int) -> Void) {
        urlSession.dataTask(with: URLComponents.generateUrl(forPath: .houses, withPage: page)) { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data, let response = response as? HTTPURLResponse {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let houses = try decoder.decode([NetworkHouseModel].self, from: data)
                    let lastPage = self.extractLastPageFromHeader(response.allHeaderFields["Link"] as! String)
                    completionCallback(houses, lastPage)
                } catch let exception {
                    print(exception)
                }
            }
        }.resume()
    }
    
    func getBook(withId id: Int, completionCallback: @escaping (NetworkBookModel) -> Void) {
        urlSession.dataTask(with: URLComponents.generateUrl(forPath: .books, withId: id)) { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let book = try decoder.decode(NetworkBookModel.self, from: data)
                    completionCallback(book)
                } catch let exception {
                    print(exception)
                }
            }
        }.resume()
    }
    
    func getCharacter(withId id: Int, completionCallback: @escaping (NetworkCharacterModel) -> Void) {
        urlSession.dataTask(with: URLComponents.generateUrl(forPath: .characters, withId: id)) { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let character = try decoder.decode(NetworkCharacterModel.self, from: data)
                    completionCallback(character)
                } catch let exception {
                    print(exception)
                }
            }
        }.resume()
    }
    
    func getHouse(withId id: Int, completionCallback: @escaping (NetworkHouseModel) -> Void) {
        urlSession.dataTask(with: URLComponents.generateUrl(forPath: .houses, withId: id)) { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                print(data)
                do {
                    let house = try decoder.decode(NetworkHouseModel.self, from: data)
                    completionCallback(house)
                } catch let exception {
                    print(exception)
                }
            }
        }.resume()
    }
    
    private func extractLastPageFromHeader(_ content: String) -> Int {
        let list = content.split(separator: ",")
        for element in list {
            if !element.contains("rel=\"last\"") {
                break
            }
            let parts = element.split(separator: ";")
            
            let link = String(parts[0])
            let range = link.range(of: "page=[0-9]+", options: .regularExpression)
            let page = String(link[range!])
            let numberString = page[ClosedRange(uncheckedBounds: (lower: String.Index(encodedOffset: 5), upper: String.Index(encodedOffset: page.count - 1)))]
            return Int(numberString)!
        }
        return 0
    }
}

fileprivate enum PathType: String {
    case books = "/books"
    case characters = "/characters"
    case houses = "/houses"
}

extension URLComponents {
    fileprivate static func generateUrl(forPath pathType: PathType, withPage page: Int) -> URL {
        var url = generateBase()
        url.path = "/api" + pathType.rawValue
        url.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "30")
        ]
        return url.url!
    }
    
    fileprivate static func generateUrl(forPath pathType: PathType, withId id: Int) -> URL {
        var url = generateBase()
        url.path = "/api" + pathType.rawValue + "/\(id)"
        return url.url!
    }
    
    private static func generateBase() -> URLComponents {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "www.anapioficeandfire.com"
        return url
    }
}

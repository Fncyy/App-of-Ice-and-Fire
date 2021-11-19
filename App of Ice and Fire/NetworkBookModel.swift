import Foundation

struct NetworkBookModel: Codable {
    init(url: String, book: NetworkBookModel) {
        self.url = url
        self.title = book.title
        self.isbn = book.isbn
        self.authors = book.authors
        self.numberOfPages = book.numberOfPages
        self.publisher = book.publisher
        self.country = book.country
        self.mediaType = book.mediaType
        self.released = book.released
        self.characterUrls = book.characterUrls
        self.povCharacterUrls = book.povCharacterUrls
    }
    
    var url: String
    let title: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: String
    let characterUrls: [String]
    let povCharacterUrls: [String]

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case title = "name"
        case isbn = "isbn"
        case authors = "authors"
        case numberOfPages = "numberOfPages"
        case publisher = "publisher"
        case country = "country"
        case mediaType = "mediaType"
        case released = "released"
        case characterUrls = "characters"
        case povCharacterUrls = "povCharacters"
    }
}

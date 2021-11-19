//
//  ViewController.swift
//  NetworkResponse
//
//  Created by RATAMATE on 12/11/21.
//

import UIKit

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

}

extension URLSession : URLSessionProtocol {
    
}

class ViewController: UIViewController {
    @IBOutlet private(set) var button: UIButton!
    private var dataTask: URLSessionDataTask?

    var session: URLSessionProtocol = URLSession.shared

    var handleResults: ([SearchResult]) -> Void = { print($0) }
    
    private(set) var results: [SearchResult] = [] {
        didSet {
            handleResults(results)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func buttonTapped(){
        searchForBook(terms: "out")

    }
    
    private func searchForBook(terms: String) {
        guard let encodedTerms = terms.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: "https://itunes.apple.com/search?" + "media=ebook&term=\(encodedTerms)") else { return }
        let request = URLRequest(url: url)
        dataTask = self.session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let self = self else { return }

            var decoded: Search?
            var errorMessage: String?
            if let error = error {
                errorMessage = error.localizedDescription
            }else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                errorMessage = "Response: " + HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            }else if let data =  data {
                do {
                    decoded = try JSONDecoder().decode(Search.self, from: data)
                }catch {
                    errorMessage = error.localizedDescription
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let decoded = decoded {
                    self.results = decoded.results
                }
                if let errorMessage = errorMessage {
                    print("errorMessage: \(errorMessage)")

                    self.showError(errorMessage)
                }
                self.dataTask = nil
                self.button.isEnabled = true
            }
        })
        button.isEnabled = false
        dataTask?.resume()
    }
    
    private func showError(_ message: String) {
        let title = "Network problem"
        print("\(title): \(message)")
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }
}

struct Search: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable, Equatable {
    let artistName: String
    let trackName: String
    let averageUserRating: Float
    let genres: [String]
}


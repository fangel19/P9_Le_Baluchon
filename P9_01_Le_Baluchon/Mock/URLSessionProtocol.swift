//
//  URLSessionProtocol.swift
//  P9_01_Le_Baluchon
//
//  Created by angelique fourny on 17/08/2021.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

//
//  ErrorMessageModel.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//


import Foundation

struct ErrorMessageModel: Error {
    let message: String
    let title: String
}

struct NetworkError {
    
    static let timeoutString = ErrorMessageModel(
        message: "Could not complete request, please try again later",
        title: "Timeout Failure"
    )
    
    static let invalidURLString = ErrorMessageModel(
        message: "oops something went wrong",
        title: "Invalid URL Failure"
    )
    
    static let badRequestString = ErrorMessageModel(
        message: "An error occurred",
        title: "Bad Request Failure"
    )
    
    static let unAuthorizedString = ErrorMessageModel(
        message: "Unauthorized, please sign in",
        title: "Unauthorized Failure"
    )
    
    static let serverErrorString = ErrorMessageModel(
        message: "oops something went wrong",
        title: "Server Error Failure"
    )
    
    static let cacheErrorString = ErrorMessageModel(
        message: "oops something went wrong",
        title: "Cache Error Failure"
    )
    
    static let notFoundString = ErrorMessageModel(
        message: "No data found error occurred",
        title: "Not Found Error Failure"
    )
    
    static let socketExceptionString = ErrorMessageModel(
        message: "oops something went wrong",
        title: "Socket Exception Failure"
    )
    
    static let noInternetConnectionString = ErrorMessageModel(
        message: "No Internet Connection",
        title: "No Connection Failure"
    )
}

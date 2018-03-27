import Foundation

/// A set of helpers for HTTP: status codes mapping, server and client request creation.
public class HTTP {
    
    /// Mapping of integer HTTP status codes to the String description.
    public static let statusCodes = [
        
        100: "Continue", 101: "Switching Protocols", 102: "Processing",
        200: "OK", 201: "Created", 202: "Accepted", 203: "Non Authoritative Information",
        204: "No Content", 205: "Reset Content", 206: "Partial Content", 207: "Multi-Status",
        300: "Multiple Choices", 301: "Moved Permanently", 302: "Moved Temporarily", 303: "See Other",
        304: "Not Modified", 305: "Use Proxy", 307: "Temporary Redirect",
        400: "Bad Request", 401: "Unauthorized", 402: "Payment Required", 403: "Forbidden", 404: "Not Found",
        405: "Method Not Allowed", 406: "Not Acceptable", 407: "Proxy Authentication Required",
        408: "Request Timeout", 409: "Conflict", 410: "Gone", 411: "Length Required",
        412: "Precondition Failed", 413: "Request Entity Too Large", 414: "Request-URI Too Long",
        415: "Unsupported Media Type", 416: "Requested Range Not Satisfiable", 417: "Expectation Failed",
        419: "Insufficient Space on Resource", 420: "Method Failure", 421: "Misdirected Request",
        422: "Unprocessable Entity", 424: "Failed Dependency", 428: "Precondition Required",
        429: "Too Many Requests", 431: "Request Header Fields Too Large",
        500: "Server Error", 501: "Not Implemented", 502: "Bad Gateway", 503: "Service Unavailable",
        504: "Gateway Timeout", 505: "HTTP Version Not Supported", 507: "Insufficient Storage",
        511: "Network Authentication Required"
    ]
    
    /// Create a new `HTTPServer`.
    ///
    /// - Returns: an instance of `HTTPServer`.
    public static func createServer() -> HTTPServer {
        return HTTPServer()
    }
}


// MARK HTTPStatusCode

/// HTTP status codes and numbers.
public enum HTTPStatusCode: Int {
    
    case accepted = 202, badGateway = 502, badRequest = 400, conflict = 409, `continue` = 100, created = 201
    case expectationFailed = 417, failedDependency  = 424, forbidden = 403, gatewayTimeout = 504, gone = 410
    case httpVersionNotSupported = 505, insufficientSpaceOnResource = 419, insufficientStorage = 507
    case internalServerError = 500, lengthRequired = 411, methodFailure = 420, methodNotAllowed = 405
    case movedPermanently = 301, movedTemporarily = 302, multiStatus = 207, multipleChoices = 300
    case networkAuthenticationRequired = 511, noContent = 204, nonAuthoritativeInformation = 203
    case notAcceptable = 406, notFound = 404, notImplemented = 501, notModified = 304, OK = 200
    case partialContent = 206, paymentRequired = 402, preconditionFailed = 412, preconditionRequired = 428
    case proxyAuthenticationRequired = 407, processing = 102, requestHeaderFieldsTooLarge = 431
    case requestTimeout = 408, requestTooLong = 413, requestURITooLong = 414, requestedRangeNotSatisfiable = 416
    case resetContent = 205, seeOther = 303, serviceUnavailable = 503, switchingProtocols = 101
    case temporaryRedirect = 307, tooManyRequests = 429, unauthorized = 401, unprocessableEntity = 422
    case unsupportedMediaType = 415, useProxy = 305, misdirectedRequest = 421, unknown = -1
    
}

extension HTTPStatusCode {

    /// The class of a `HTTPStatusCode` code
    /// - See: https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml for more information
    public enum Class {
        /// Informational: the request was received, and is continuing to be processed
        case informational
        /// Success: the action was successfully received, understood, and accepted
        case successful
        /// Redirection: further action must be taken in order to complete the request
        case redirection
        /// Client Error: the request contains bad syntax or cannot be fulfilled
        case clientError
        /// Server Error: the server failed to fulfill an apparently valid request
        case serverError
        /// Invalid: the code does not map to a well known status code class
        case invalidStatus

        init(code: Int) {
            switch code {
                case 100..<200: self = .informational
                case 200..<300: self = .successful
                case 300..<400: self = .redirection
                case 400..<500: self = .clientError
                case 500..<600: self = .serverError
                default: self = .invalidStatus
            }
        }
    }

    /// The `Class` representing the class of status code for this response status
    public var `class`: Class {
        return Class(code: self.rawValue)
    }

}

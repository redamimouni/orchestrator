import Vapor

struct Payload: Content {
    let review: Review
    let pull_request: PullRequest
}

struct Review: Content {
    let pull_request_url : String
}

struct PullRequest: Content {
    let number: Int
}

enum EventType: String {
    case STATUS = "status"
    case PULL_REQUEST = "pull_request_review"
    case UNKNOWN = "unknown"
}

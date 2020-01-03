import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    
    router.post("payload") { req -> Future<HTTPStatus> in
        print(req.http.headers["X-GitHub-Event"].first ?? "Unknown Event")
        let event = handleEvent(req: req)
        switch event {
            
        case .STATUS: break
            
        case .PULL_REQUEST:
            return try req.content.decode(Payload.self).map(to: HTTPStatus.self, { payload in
                print(payload.pull_request.number)
                return .ok
            })
        case .UNKNOWN: break
        }
        return try req.content.decode(Payload.self).map(to: HTTPStatus.self, { payload in
            print(payload.review.pull_request_url)
            return .ok
        })
    }

    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

func handleEvent(req: Request) -> EventType {
    return EventType(rawValue: req.http.headers["X-GitHub-Event"].first ?? "unknown") ?? EventType.UNKNOWN
}

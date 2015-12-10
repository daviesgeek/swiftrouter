# swiftrouter

This is largely based on https://github.com/takebayashi/swiftra. I started playing with swiftra, and didn't like some of the things about it, so I set out to create my own version of it. The name, API and just about everything about this code base is subject to change.

More detailed docs and such will be on the way. See [the example folder](https://github.com/daviesgeek/swiftrouter/tree/master/example) for an example of a simple application

## Running the router

```swift

// Create an instance
let router = Router()

// Define your routes here (see below)

router.server(8080) // Pass in the port you want to run the server on
```

## Defining routes

Routes can be defined in one of two ways:

```swift

// With a closure

router.get("/") {req in 
  Response("This is the main page")
}

// With a class and method (must conform to the Controller protocol)

class MainController : Controller {
  required init() {}

  func index(request: HTTPRequest) -> Response {
    return Response("This is the main page from a controller method")
  }
}

router.get("/", ctrl: MainController.self, method: MainController.index)

```
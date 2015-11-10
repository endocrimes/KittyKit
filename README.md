# KittyKit
A Swift framework for interacting with small.cat

# Usage

```swift
import KittyKit

let urlStringToShorten = "http://endocrimes.com"
let expiry = URLExpiry.TenMins

let kittyLitter = APIClient()
kittyLitter.fetchAuthenticityToken { result in
  guard let token = result.left else {
      return
  }
  
  kittyLitter.submitURL(urlStringToShorten, expiry: expiry, token: token) { result in
      guard let url = result.left else {
          return
      }
      
      print(url)
  }
}

```

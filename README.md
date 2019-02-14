# iRecipe

This is a simple iOS app to search recipes using recipe puppy API.

## 🚨 Important note 🚨

This project is using cocoapods and the pods are included in the repo. Anyway if you have any problem please run the **pod install** command.

If you have any doubt about cocoapods you can check the reference [here](https://cocoapods.org).

## Project Architecture 
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/projectArchitecture.jpeg?raw=true)

References:
* [Viper architecture](https://www.objc.io/issues/13-architecture/viper/)
* [Viper for iOS](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6)

## How did I implement VIPER?

Basically I have a protocol file for each scene in the app. This file defines the interaction between each layer as following:

* View - Presenter: protocols to notify changes and to inject information to the UI.
* Presenter - Interactor: protocols to request / receive information to / from the interactor.
* Presenter - Router: protocol to define the transitions between scenes.

Whith this protocols file is really easy to know how each layer notify / request / information to the other ones so we don't have any other way to communicate all the layers.

Another important point is because I'm using protocols it's really easy to define mocks views / presenters / interactors / routers for testing.

```swift
// View / Presenter
protocol RecipesListViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
    func loadRecipes(_ viewModels: [RecipeViewModel], fromBeginning: Bool)
}

protocol RecipesListPresenterDelegate : class {
    func viewDidLoad()
    func searchRecipe(_ recipe: String?)
    func recipeSelectedAt(_ index: Int)
    func makeFavoriteSelectedAt(_ index: Int)
    func loadMoreRecipes()
}

// Presenter / Interactor

typealias RecipesGetRecipesCompletionBlock = (_ viewModel: [RecipeViewModel]?, _ success: Bool, _ error: ResultError?) -> Void

protocol RecipesListInteractorDelegate : class {
    func getRecipeList(search: String?, completion: @escaping RecipesGetRecipesCompletionBlock)
    func clear()
    func getRecipeSelectedAt(_ index: Int) -> RecipeViewModel?
}

// Presenter / Router
protocol RecipesListRouterDelegate : class {
    func showRecipeDetailWithUrl(_ url: URL)
}
```

## First at all. Where is the data came from?

I'm using the api from the free API called Recipe Puppy. You can check the API [here](http://www.recipepuppy.com/about/api/).

## Data models

### Network data models

```swift
public struct RecipesResponse: Decodable {
    
    let results: [RecipeResponse]
    
}

public struct RecipeResponse: Decodable {
    
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
    
}
```

I'm using a Swift Standard Library decodable functionality in order to manage a type that can decode itself from an external representation (I really ❤ this from Swift).

Reference: [Apple documentation](https://developer.apple.com/documentation/swift/swift_standard_library/encoding_decoding_and_serialization)

### Local favorite recipes data model

This model is used for the local favorite recipe:

```swift
class FavoriteRecipe: Object {
    @objc dynamic var recipeId: String?
    @objc dynamic var title: String = ""
    @objc dynamic var href: String = ""
    @objc dynamic var ingredients: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var timestamp: TimeInterval = NSDate().timeIntervalSince1970
    
    override class func primaryKey() -> String? {
        return "recipeId"
    }
}
```

As I'm using Realm for this it's important to define a class to manage each model in the database. In this case we only have one model (FavoriteRecipe)

Reference: [Realm](https://realm.io/docs/swift/latest)

## How it looks like?

### Recipes list && search
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/01.png?raw=true)
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/02.png?raw=true)

### Favorite recipes
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/03.png?raw=true)
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/04.png?raw=true)
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/05.png?raw=true)

### No internet connection screen
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/06.png?raw=true)

### No results
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/07.png?raw=true)
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/08.png?raw=true)

### iPad
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/iPad01.png?raw=true)
![alt tag](https://github.com/rcasanovan/iRecipe/blob/master/Images/iPad02.png?raw=true)

## What's left in the demo?

* Realm migration process: It would be nice to add a process to migrate the realm database to a new model (just in case you need to add a new field into the database).
* Localizable strings files: I didn't add localizable strings files because the API can't return the recipes using translations (en, es, etc). It would be nice to have the option to send the device language in the url in order to get the recipes in defferent languages (and to add the localizable strings files too).
* Icons (app / tabbar): I didn't add any icon for the app or the tabbar. It would be nice to add the icons for the app in the future.
* Update the managers: I implemented the managers using singletons. The best option should be to remove the singletons in order to user dependency injections (to improve the testing).

## Programming languages && Development tools

* Swift 4.2
* Xcode 10.1
* [Cocoapods](https://cocoapods.org) 1.5.3
* Minimun iOS version: 12.1

## Third-Party Libraries

* [RealmSwift](https://github.com/realm/realm-cocoa) (3.13.1): A mobile database that runs directly inside phones, tablets or wearables.
* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) (2.2.5): A clean and lightweight progress HUD for your iOS and tvOS app.
* [Haneke](https://github.com/Haneke/Haneke) (1.0): A lightweight zero-config image cache for iOS, in Objective-C.

## Support && contact

### Email

You can contact me using my email: ricardo.casanova@outlook.com

### Twitter

Follow me [@rcasanovan](http://twitter.com/rcasanovan) on twitter.
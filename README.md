# URLImagePlaceholder

URLImagePlaceholder is a Swift package that provides a customizable UIImageView subclass with fallback text for displaying remote images. It allows you to set a placeholder image and display a fallback text when the image URL is invalid or fails to load.

## Features

- Display remote images with fallback text.
- Customize the fallback label's text, font, and color.
- Set a placeholder image to display while the image is being fetched.

## Installation

### Swift Package Manager

You can easily integrate URLImagePlaceholder into your Swift package by adding it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your/repo.git", from: "1.0.0")
]
```
Usage
Import the URLImagePlaceholder module in your Swift file:
```swift
let imageView = URLImagePlaceholder(fallbackText: "Image Failed to Load", frame: CGRect(x: 0, y: 0, width: 200, height: 200))
Set the image URL using the setImageURL method:

if let url = URL(string: "https://example.com/image.jpg") {
    imageView.setImageURL(url, placeholderImage: UIImage(named: "placeholder"))
}
```

Customization
The URLImagePlaceholder class allows customization of the following properties:
* fallbackText: The text to display when the image fails to load.
* fallbackTextColor: The color of the fallback text.
* fallbackTextFont: The font of the fallback text.

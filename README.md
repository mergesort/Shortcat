# Shortcat

#### Navigate UITableViews with cat-like agility. For once you'll be thrilled to have a cat on your keyboard. 🐱

---

[![Pod Version](https://img.shields.io/badge/Pod-1.0-1.0.6193DF.svg)](https://cocoapods.org/)
![Swift Version](https://img.shields.io/badge/Swift-4.2-brightgreen.svg)
![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg) 
![Plaform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)

## Todo

- [ ] A better README
- [ ] Demo gif
- [ ] Push to CocoaPods

## SHOW ME THE CODE

Ok, calm down Jerry Maguire. That movie is overrated anyway.

```swift
extension MyVERYEnthusiasticViewController: ShortcutNavigatableTableViewController {

    public override var keyCommands: [UIKeyCommand]? {
        return self.navigationAndInputKeyCommands
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimationNavigationHandler(scrollView)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollViewWillBeginDraggingNavigationHandler(scrollView)
    }

}
```

## Q&A

**Q: That's it? You get _all_ the keyboard navigation with just a few lines of code?**

A: Yeah, don't you trust me? Why would I lie to you, I don't even know you?

**Q: What if I want to add my own keyboard shortcuts?**

A: `self.navigationAndInputKeyCommands` is an array of `UIKeyCommand`s, so feel free to add your own as you wish.

Something like this should be good for most use cases.

```swift
public override var keyCommands: [UIKeyCommand]? {
    let customKeyCommands = [
        UIKeyCommand(input: "t", modifierFlags: .command, action: #selector(openNewTab)),
        UIKeyCommand(input: "w", modifierFlags: .command, action: #selector(closeWindow)),
        UIKeyCommand(input: "q", modifierFlags: .command, action: #selector(quitApplication)),
    ]

    return self.navigationKeyCommands + customKeyCommands
}
```

**Q: I ran out of questions.**

A: Yeah, I noticed, that's not a question.


## Inspiration

This project is inspired by the great work [@donohue](https://github.com/donohue) did for [IPShortcut](https://github.com/Instapaper/IPShortcut).

#### Advantages over IPShortcut:

- Uses protocols/extensions to add support any UIViewController with just a few lines of code rather than subclassing.
- Supports multiple sections which IPShortcut does not presently.
- I wrote it so now I get to maintain it. Can't wait to see how that goes. \o/

#### Disadvantages:
- Not Objective-C compatible.
- It's not written by Brian, who is a wonderful fella.
- I wrote it so now I get to maintain it. Can't wait to see how that goes. \o/

## Installation
You can use [CocoaPods](http://cocoapods.org/) to install `Shortcat` by adding it to your `Podfile`:

```swift
platform :ios, '9.0'
use_frameworks!

pod 'Shortcat'
```

Or install it manually by downloading the Swift files in the `Source` folder, and dropping them in your project.

## About me

Hi, I'm [Joe](http://fabisevi.ch) everywhere on the web, but especially on [Twitter](https://twitter.com/mergesort).

## License

See the [license](LICENSE) for more information about how you can use Shortcat.

## Is that it?

🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱

Yes.

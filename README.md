# SpinKit
[![Download](https://img.shields.io/cocoapods/v/SpinKitFramework.svg)](https://cocoapods.org/pods/SpinKitFramework)
[![CocoaPods platforms](https://img.shields.io/cocoapods/p/SpinKitFramework.svg)](https://cocoapods.org/pods/SpinKitFramework)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Based on [tobiasahlin's CSS SpinKit](https://github.com/tobiasahlin/SpinKit), SpinKit is a friendly framework that provides with a set of spinners or loaders. They're perfect to use when your App faces a heavy load task or to help with a transition between scenes.

## Usage
Every `Spinner` is a view that implements the `SpinnerType` interface and exposes four properties to customize it. To start a spinner, simply call its `startLoading` method. Here's some sample code:

```swift
let spinner = WaveSpinner(primaryColor: selectedColor,
                              frame: CGRect(origin: .zero,
                                            size: CGSize(width: 50,
                                                         height: 50)))
 
 spinner.startLoading()
```
<img src="/resources/wave_spiner.gif" width="100" title="Wave Spinner">

## Customization
You can change its color, speed of the animation and modify its content insets:
```swift
spinner.primaryColor = UIColor.green
spinner.contentInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
spinner.animationSpeed = 3      // Speeds up the animation by 3
```

**Note:** Don't change these properties once the spinner has started the animation. Some of them are used as part of the animation and it might not have the expected result.

You can also set the `isTranslucent` property to false (default is true). This makes the view take the `primaryColor` and show the spinner in a white tint.

* Translucent spinner
<img src="/resources/double_bounce.gif" width="100" title="Wave Spinner">

* Opaque spinner
<img src="/resources/double_bounce_translucent.gif" width="100" title="Wave Spinner">

## Available Spinners
Choose the one you like the most ;)
#### Rotating plane
<img src="/resources/rotating_plane.gif" width="100" title="Rotating plane spinner">

#### Double bounce
<img src="/resources/double_bounce_red.gif" width="100" title="Double bounce spinner">

#### Wave
<img src="/resources/wave_red.gif" width="100" title="Wave spinner">

#### Wandering cubes
<img src="/resources/wandering_cubes.gif" width="100" title="Wandering cubes spinner">

#### Pulse
<img src="/resources/pulse.gif" width="100" title="Pulse spinner">

#### Chasing dots
<img src="/resources/chasing_dots.gif" width="100" title="Chasing dots spinner">

#### Three bounce
<img src="/resources/three_bounce.gif" width="100" title="Three bounce spinner">

#### Circle
<img src="/resources/circle.gif" width="100" title="Circle spinner">

#### Cube grid
<img src="/resources/cube_grid.gif" width="100" title="Cube grid spinner">

#### Fading circle
<img src="/resources/fading_circle.gif" width="100" title="Fading circle spinner">

#### Folding cube
<img src="/resources/folding_cube_spinner_red.gif" width="100" title="Folding cube spinner">

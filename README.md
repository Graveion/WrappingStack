# WrappingStack
A layout component designed to allow content to overflow onto multiple rows and columns


## Installation
Requirements iOS 16+

### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/graveion/WrappingStack) and click Next.
4. Click Finish.

## Usage

Arrangement:
* `.ordered`: Items will be added to the stack in the order they are provided, even if there is space on a row for a newly added item.

* `.bestFit`: Items will be added to the row which has the most space remaining, assuming it will fit 

Alignment:

![Alignment](./alignment.gif?raw=true)

Spacing:
* `itemSpacing`: The space between items

* `rowSpacing` : The space between each row


Example:
An example of a mix of views: image views, text and buttons with vertical and horizontally stacked text

![Mixed Views](./mixedViewsWrapping.png)

## Featured In:

Brew - https://github.com/Jenm-b/Brew 

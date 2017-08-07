import Foundation

/**
 
 An enum to set type of navigation title.
 
 - parameters:
 - title: Set navigation title as string.
 - index: Set navigation title as index of items.
 Items is defined from DropdownView initialization.
 */
public enum DropdownTitle {
  case title(String)
  case index(Int)
}

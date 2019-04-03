module BootstrapStarter exposing (BootstrapStarter, PageContent(..), NavBarLink(..), NavBarVanilla, NavBarDropDown, NavBarDropDownItem, renderPage)

{-|

# Creating BootstrapStarter master view types
@docs BootstrapStarter
# Rendering as Html
@docs renderPage

-}

import Html exposing (..)


{-| A Master Page Type that represents the Bootstrap Starter Template (https://getbootstrap.com/docs/4.0/examples/starter-template/#)
-}
type alias BootstrapStarter msg = {
    navBarTitle : String 
    , navBarLinks : List NavBarLink
    , searchTitle : String
    , pageTitle : String
    , pageContent : PageContent msg  
}

{-| Represents the body of a page, can be a list of strings (paragraphs), or a list of custom html
-}
type PageContent msg = 
    Paragraphs (List String)
    | Custom (List (Html msg))


{-| Represents a NavBarLink 
-}
type NavBarLink = 
    Vanilla NavBarVanilla
    | DropDown NavBarDropDown

{-| Represents a vanilla NavBarLink 
-}
type alias NavBarVanilla = {
    title: String
    , url: String
    , selected: Bool
    , disabled: Bool
}

{-| Represents A NavBarLink drop down list
-}
type alias NavBarDropDown = {
    title: String
    , id: String
    , url: String
    , items: List NavBarDropDownItem
}

{-| Represents A NavBarLink drop down list item
-}
type alias NavBarDropDownItem = {
    title: String
    , url: String
}

renderPage: BootstrapStarter msg -> Html msg
renderPage bootstrap =
    div [] [ div [] [] ]
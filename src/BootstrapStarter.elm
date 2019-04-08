module BootstrapStarter exposing (BootstrapStarter, PageContent(..), NavBarLink(..), NavBarVanilla, NavBarDropDown, NavBarDropDownItem, renderPage, renderNavBarDropDownItem, renderNavBarDropDown)

-- add comment about scope / visisibility and having to make so for the tests

{-|

# Creating BootstrapStarter master view types
@docs BootstrapStarter
# Rendering as Html
@docs renderPage

-}

import Html.String as Html exposing (Html)
import Html.String.Attributes as Attributes
--import Html exposing (..)
--import Html.Attributes exposing (..)


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

{-| Renders a BootstrapStarter to Html
-}
renderPage: BootstrapStarter msg -> Html msg
renderPage bootstrap =
    Html.div [] [ ]

-- <a class="dropdown-item" href="#">Action</a>
renderNavBarDropDownItem: NavBarDropDownItem -> Html msg
renderNavBarDropDownItem navBarDropDownItem =
    Html.a 
        [ Attributes.class "dropdown-item", Attributes.href navBarDropDownItem.url ]
        [ Html.text navBarDropDownItem.title ] 

-- <li class="nav-item dropdown">
--   <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Title</a>
--   <div class="dropdown-menu" aria-labelledby="dropdown01">
--     <a class="dropdown-item" href="#">Action</a>
--   </div>
-- </li>
renderNavBarDropDown: NavBarDropDown -> Html msg
renderNavBarDropDown navBarDropDown =
    Html.li 
        [ Attributes.class "nav-item dropdown" ]
        [   Html.a 
                [ Attributes.class "nav-link dropdown-toggle", Attributes.href navBarDropDown.url, Attributes.id navBarDropDown.id ]
                [ Html.text navBarDropDown.title ],
            Html.div
                [ Attributes.class "dropdown-menu" ]
                (List.map renderNavBarDropDownItem navBarDropDown.items)
        ] 
module BootstrapStarter exposing (BootstrapStarter, PageContent(..), NavBarLink(..), NavBarVanilla, LinkState(..), NavBarDropDown, NavBarDropDownItem, renderPage, renderNavBarDropDownItem, renderNavBarDropDown, renderNavBarVanilla)

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

-- add types for some things. url, maybe title.

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
    , state: LinkState
}

type LinkState = 
    LinkStateVanilla
    | LinkStateSelected
    | LinkStateDisabled
 

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
                [   
                    Attributes.class "nav-link dropdown-toggle", 
                    Attributes.href navBarDropDown.url,
                    Attributes.id navBarDropDown.id,
                    Attributes.attribute "data-toggle" "dropdown",
                    Attributes.attribute "aria-haspopup" "true",
                    Attributes.attribute "aria-expanded" "false"
                ]
                [ Html.text navBarDropDown.title ],
            Html.div
                [ 
                    Attributes.class "dropdown-menu",
                    Attributes.attribute "aria-labelledby" navBarDropDown.id
                 ]
                (List.map renderNavBarDropDownItem navBarDropDown.items)
        ] 

-- <li class="nav-item active">
--     <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
-- </li>active
-- <li class="nav-item">
--     <a class="nav-link" href="#">Link</a>
-- </li>
-- <li class="nav-item">
--     <a class="nav-link disabled" href="#">Disabled</a>
-- </li>
renderNavBarVanilla: NavBarVanilla -> Html msg
renderNavBarVanilla navBarVanilla =
    Html.li 
        [ Attributes.class ("nav-item" ++ selectedClass navBarVanilla.state) ]
        [   Html.a 
                [   
                    Attributes.class ("nav-link" ++ disabledClass navBarVanilla.state), 
                    Attributes.href navBarVanilla.url
                ]
                [ Html.text (navBarVanilla.title ++ selectedSpan navBarVanilla.state) ]
        ] 

-- repeating the case statement in selectedClass and selectedSpan is a bit of a code smell but I'm not going to worry about it for now
selectedClass: LinkState -> String
selectedClass linkState =
    case linkState of 
        LinkStateSelected ->
            " active"
        _ ->
            ""

selectedSpan: LinkState -> String
selectedSpan linkState =
    case linkState of 
        LinkStateSelected ->
            """ <span class="sr-only">(current)</span>"""
        _ ->
            ""

disabledClass: LinkState -> String
disabledClass linkState =
    case linkState of 
        LinkStateDisabled ->
            " disabled"
        _ ->
            ""

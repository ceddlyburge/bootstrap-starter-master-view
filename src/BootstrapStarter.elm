module BootstrapStarter exposing (
    BootstrapStarter, 
    PageContent(..), 
    NavBarLink(..), 
    NavBarVanilla, 
    LinkState(..), 
    NavBarDropDown, 
    NavBarDropDownItem, 
    renderPage, 
    renderNavBarDropDownItem, 
    renderNavBarDropDown, 
    renderNavBarVanilla, 
    renderSearch,
    renderNavBar,
    renderNavBarLinks,
    renderPageTitleAndContent)

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
    | Custom (List (Html msg) )


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
    Html.div
        []
        [ renderNavBar bootstrap.searchTitle bootstrap.navBarLinks
        , renderPageTitleAndContent bootstrap.pageTitle bootstrap.pageContent ]  

-- <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
--   <a class="navbar-brand" href="#">Navbar</a>
--   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
--     <span class="navbar-toggler-icon"></span>
--   </button>
--   <div class="collapse navbar-collapse" id="navbarsExampleDefault">
--     <ul class="navbar-nav mr-auto">
--       <li class="nav-item">
--         <a class="nav-link" href="#">Link</a>
--       </li>  
--     </ul>
--     <form class="form-inline my-2 my-lg-0">
--       <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
--       <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
--     </form>
--   </div>
-- </nav>
renderNavBar: String -> List NavBarLink -> Html msg
renderNavBar searchTitle navBarLinks =
    Html.nav
        [ Attributes.class "navbar navbar-expand-md navbar-dark bg-dark fixed-top" ]
        [ Html.a 
            [ Attributes.class "navbar-brand", Attributes.href "#" ]
            [ Html.text "Navbar" ]
        , Html.button 
            [ Attributes.class "navbar-toggler"
            , Attributes.attribute "type" "button"
            , Attributes.attribute "data-toggle" "collapse"
            , Attributes.attribute "data-target" "#navbarsExampleDefault"
            , Attributes.attribute "aria-controls" "navbarsExampleDefault"
            , Attributes.attribute "aria-expanded" "false"
            , Attributes.attribute "aria-label" "Toggle navigation"
            ]
            [ Html.span 
                [ Attributes.class "navbar-toggler-icon" ]
                []
            ]
        , Html.div
            [ Attributes.class "collapse navbar-collapse"
            , Attributes.id "navbarsExampleDefault" ]
            [ renderNavBarLinks navBarLinks
            , renderSearch searchTitle ]
        ]

renderNavBarLinks: List NavBarLink -> Html msg
renderNavBarLinks navBarLinks =
    Html.ul
        [ Attributes.class "navbar-nav mr-auto" ]
        ( List.map renderNavBarLink navBarLinks)

renderNavBarLink: NavBarLink -> Html msg
renderNavBarLink navBarlink =
    case navBarlink of 
        Vanilla navBarLinkVanilla ->
            renderNavBarVanilla navBarLinkVanilla
        DropDown navBarDropDown ->
            renderNavBarDropDown navBarDropDown 

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

-- <a class="dropdown-item" href="#">Action</a>
renderNavBarDropDownItem: NavBarDropDownItem -> Html msg
renderNavBarDropDownItem navBarDropDownItem =
    Html.a 
        [ Attributes.class "dropdown-item", Attributes.href navBarDropDownItem.url ]
        [ Html.text navBarDropDownItem.title ] 

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
                (
                    [ Html.text navBarVanilla.title ] 
                    ++ selectedSpan navBarVanilla.state
                ) 
        ] 

-- <form class="form-inline my-2 my-lg-0">
--   <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
--   <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
-- </form>
renderSearch: String -> Html msg
renderSearch searchTitle =
    Html.form 
        [ Attributes.class "form-inline my-2 my-lg-0" ]
        [ Html.input 
            [ Attributes.class "form-control mr-sm-2"
            , Attributes.attribute "type" "text" 
            , Attributes.attribute "placeholder" searchTitle 
            , Attributes.attribute "aria-label" searchTitle 
            ] 
            []
        , Html.button 
            [ Attributes.class "btn btn-outline-success my-2 my-sm-0"
            , Attributes.attribute "type" "submit" 
            ] 
            [ Html.text searchTitle ]   
        ] 

renderPageTitleAndContent: String -> PageContent msg -> Html msg
renderPageTitleAndContent pageTitle pageContent =
    Html.main_
        [ Attributes.attribute "role" "main"
        , Attributes.class "container" 
        ] 
        [ Html.div
            [ Attributes.class "starter-template" ] 
            (
                [ Html.h1 
                    []
                    [ Html.text pageTitle ]
                ]
                ++ renderPageContent pageContent
            )
        ]

renderPageContent: PageContent msg -> List (Html msg)
renderPageContent pageContent =
    case pageContent of
        Paragraphs paragraphs ->
            List.map (\(paragraph) -> Html.p [] [ Html.text paragraph ]) paragraphs
        Custom customHtml ->
            customHtml

-- repeating the case statement in selectedClass and selectedSpan is a bit of a code smell but I'm not going to worry about it for now
selectedClass: LinkState -> String
selectedClass linkState =
    case linkState of 
        LinkStateSelected ->
            " active"
        _ ->
            ""

selectedSpan: LinkState -> List (Html msg)
selectedSpan linkState =
    case linkState of 
        LinkStateSelected ->
            [ Html.span 
                [ Attributes.class "sr-only" ]
                [ Html.text "(current)" ]
            ]
        _ ->
            []

disabledClass: LinkState -> String
disabledClass linkState =
    case linkState of 
        LinkStateDisabled ->
            " disabled"
        _ ->
            ""

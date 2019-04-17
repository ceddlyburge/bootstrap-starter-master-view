module BootstrapStarterRenderHtmlString exposing (
    toHtmlString, 
    navBarDropDownItemToHtmlString, 
    navBarDropDownToHtmlString, 
    navBarVanillaToHtmlString, 
    searchToHtmlString,
    navBarToHtmlString,
    navBarLinksToHtmlString,
    pageTitleAndContentToHtmlString)

import Html.String as Html exposing (Html)
import Html.String.Attributes as Attributes
import Html.String.Events as Events
import BootstrapStarter exposing (..)

-- add comment about scope / visisibility and having to make so for the tests

toHtmlString: BootstrapStarter msg -> Html msg
toHtmlString bootstrap =
    Html.node
        "div"
        []
        (
            [ navBarToHtmlString bootstrap.navBar
            , pageTitleAndContentToHtmlString bootstrap.pageTitle bootstrap.pageContent
            ]  
        )

navBarToHtmlString: NavBar msg -> Html msg
navBarToHtmlString navBar =
    Html.nav
        [ Attributes.class "navbar navbar-expand-md navbar-dark bg-dark fixed-top" ]
        [ Html.a 
            [ Attributes.class "navbar-brand"
            , Attributes.tabindex 1   ]
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
            [ navBarLinksToHtmlString navBar.navBarLinks
            , searchToHtmlString navBar.search ]
        ]

navBarLinksToHtmlString: List (NavBarLink msg) -> Html msg
navBarLinksToHtmlString navBarLinks =
    Html.ul
        [ Attributes.class "navbar-nav mr-auto" ]
        ( List.map navBarLinkToHtmlString navBarLinks)

navBarLinkToHtmlString: NavBarLink msg -> Html msg
navBarLinkToHtmlString navBarlink =
    case navBarlink of 
        Vanilla navBarLinkVanilla ->
            navBarVanillaToHtmlString navBarLinkVanilla
        DropDown navBarDropDown ->
            navBarDropDownToHtmlString navBarDropDown 

navBarDropDownToHtmlString: NavBarDropDown msg -> Html msg
navBarDropDownToHtmlString navBarDropDown =
    Html.li 
        [ Attributes.class "nav-item dropdown" ]
        [   Html.a 
                [   
                    Attributes.class "nav-link dropdown-toggle", 
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
                (List.map navBarDropDownItemToHtmlString navBarDropDown.items)
        ] 

navBarDropDownItemToHtmlString: NavBarDropDownItem msg -> Html msg
navBarDropDownItemToHtmlString navBarDropDownItem =
    Html.a 
        [ Attributes.class "dropdown-item"
        , Events.onClick navBarDropDownItem.onClick ]
        [ Html.text navBarDropDownItem.title ] 

navBarVanillaToHtmlString: NavBarVanilla msg -> Html msg
navBarVanillaToHtmlString navBarVanilla =
    Html.li 
        [ Attributes.class ("nav-item" ++ selectedClass navBarVanilla.state) ]
        [   Html.a 
                [   
                    Attributes.class ("nav-link" ++ disabledClass navBarVanilla.state)
                    , Events.onClick navBarVanilla.onClick
                ]
                (
                    [ Html.text navBarVanilla.title ] 
                    ++ selectedSpan navBarVanilla.state
                ) 
        ] 

searchToHtmlString: Search msg -> Html msg
searchToHtmlString search =
    Html.form 
        [ Attributes.class "form-inline my-2 my-lg-0" ]
        [ Html.input 
            [ Attributes.class "form-control mr-sm-2"
            , Attributes.attribute "type" "text" 
            , Attributes.attribute "placeholder" search.title 
            , Attributes.attribute "aria-label" search.title 
            , Events.onInput search.onInput
            ] 
            []
        , Html.button 
            [ Attributes.class "btn btn-outline-success my-2 my-sm-0"
            , Attributes.attribute "type" "button" 
            , Events.onClick search.onClick 
            ] 
            [ Html.text search.title ]   
        ] 

pageTitleAndContentToHtmlString: String -> PageContent msg -> Html msg
pageTitleAndContentToHtmlString pageTitle pageContent =
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
                ++ pageContentToHtmlString pageContent
            )
        ]

pageContentToHtmlString: PageContent msg -> List (Html msg)
pageContentToHtmlString pageContent =
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

-- These render as p tags so are not useful.
-- renderBootstrapScripts: List (Html msg)
-- renderBootstrapScripts =
--         [ Html.node 
--             "script"
--             [ Attributes.attribute "src" "https://code.jquery.com/jquery-3.2.1.slim.min.js"
--             , Attributes.attribute "integrity" "sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
--             , Attributes.attribute "crossorigin" "anonymous"
--             ]
--             []
--         , Html.node 
--             "script"
--             [ Attributes.attribute "src" "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
--             , Attributes.attribute "integrity" "sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
--             , Attributes.attribute "crossorigin" "anonymous"
--             ]
--             []    
--         , Html.node 
--             "script"
--             [ Attributes.attribute "src" "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
--             , Attributes.attribute "integrity" "sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
--             , Attributes.attribute "crossorigin" "anonymous"
--             ]
--             []    
--         ]


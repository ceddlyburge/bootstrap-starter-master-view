module BootstrapStarterTests exposing (..)

import Test exposing (..)
import Expect exposing (..)
import BootstrapStarter exposing (..)
import BootstrapStarterRenderHtmlString exposing (..)
import Html.String as Html exposing (Html)

navBarDropDownItem : Test
navBarDropDownItem =
    test "navBarDropDownItem returns correct html" <|
        \() ->
            navBarDropDownItemToHtmlString (NavBarDropDownItem "Action" ()) 
            |> Html.toString 0 
            |> Expect.equal """<a class="dropdown-item">Action</a>"""

navBarDropDown : Test
navBarDropDown =
    test "navBarDropDown returns correct html" <|
        \() ->
            navBarDropDownToHtmlString 
              ( NavBarDropDown
                  "Title"
                  "dropdown01"
                  [ NavBarDropDownItem "Action" () ])
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" aria-expanded="false" aria-haspopup="true" data-toggle="dropdown" id="dropdown01">Title</a><div class="dropdown-menu" aria-labelledby="dropdown01"><a class="dropdown-item">Action</a></div></li>""" 


navBarLinkVanillaSelected : Test
navBarLinkVanillaSelected =
    test "navBarVanilla returns correct html when selected" <|
        \() ->
            navBarVanillaToHtmlString (NavBarVanilla "Home" () LinkStateSelected) 
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item active"><a class="nav-link">Home<span class="sr-only">(current)</span></a></li>"""


navBarLinkVanillaDisabled : Test
navBarLinkVanillaDisabled =
    test "navBarVanilla returns correct html when disabled" <|
        \() ->
            navBarVanillaToHtmlString (NavBarVanilla "Disabled" () LinkStateDisabled) 
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item"><a class="nav-link disabled">Disabled</a></li>"""

navBarLinkVanilla : Test
navBarLinkVanilla =
    test "navBarVanilla returns correct html when in vanilla state" <|
        \() ->
            navBarVanillaToHtmlString (NavBarVanilla "Link" () LinkStateVanilla) 
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item"><a class="nav-link">Link</a></li>"""

navBarLinks : Test
navBarLinks =
    test "renderNavBarLinks returns correct html" <|
        \() ->
            navBarLinksToHtmlString [ Vanilla <| NavBarVanilla "Link" () LinkStateVanilla ]
            |> Html.toString 0 
            |> Expect.equal """<ul class="navbar-nav mr-auto"><li class="nav-item"><a class="nav-link">Link</a></li></ul>"""
  
search : Test
search =
    test "renderSearch returns correct html" <|
        \() ->
            searchToHtmlString (Search "Search" (\s -> ()) () )
            |> Html.toString 0
            |> Expect.equal """<form class="form-inline my-2 my-lg-0"><input class="form-control mr-sm-2" aria-label="Search" placeholder="Search" type="text"><button class="btn btn-outline-success my-2 my-sm-0" type="button">Search</button></form>"""


navBar : Test
navBar =
    test "renderNavBar returns correct html" <|
        \() ->
            navBarToHtmlString 
              (NavBar 
                "Navbar"
                ()
                [ Vanilla <| NavBarVanilla "Link" () LinkStateVanilla ]
                (Search "Search" (\s -> ()) ())
              ) 
            |> Html.toString 2
            |> String.filter isBlackspace
            |> Expect.equal (String.filter isBlackspace """<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" tab-index="1">
    Navbar
  </a>
  <button class="navbar-toggler" aria-label="Toggle navigation" aria-expanded="false" aria-controls="navbarsExampleDefault" data-target="#navbarsExampleDefault" data-toggle="collapse" type="button">
    <span class="navbar-toggler-icon">
    </span>
  </button>
  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link">
          Link
        </a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" aria-label="Search" placeholder="Search" type="text">
      <button class="btn btn-outline-success my-2 my-sm-0" type="button">
        Search
      </button>
    </form>
  </div>
</nav>""")

pageTitleAndContentParagraphs : Test
pageTitleAndContentParagraphs =
    test "pageTitleAndContent returns p tags for each paragraph" <|
        \() ->
            pageTitleAndContentToHtmlString "Header" ( Paragraphs [ "a", "b" ] )
            |> Html.toString 0
            |> Expect.equal """<main class="container" role="main"><div class="starter-template"><h1>Header</h1><p>a</p><p>b</p></div></main>"""

pageTitleAndContentCustom : Test
pageTitleAndContentCustom =
    test "pageTitleAndContent returns passed custom content" <|
        \() ->
            pageTitleAndContentToHtmlString "Heading" (Custom <| [ Html.div [] [] ] )
            |> Html.toString 0
            |> Expect.equal """<main class="container" role="main"><div class="starter-template"><h1>Heading</h1><div></div></div></main>"""

endToEnd : Test
endToEnd =
    test "BootstrapStarter returns same html as bootstrap example page (https://getbootstrap.com/docs/4.0/examples/starter-template/)" <|
        \() ->
            let
                masterPageType = 
                    BootstrapStarter
                        (NavBar 
                          "Navbar" 
                          ()
                          [
                            Vanilla (NavBarVanilla "Home" () LinkStateSelected)
                            , Vanilla (NavBarVanilla "Link" () LinkStateVanilla)
                            , Vanilla (NavBarVanilla "Disabled" () LinkStateDisabled)
                            , DropDown (NavBarDropDown
                                "Dropdown"
                                "dropdown01"
                                [
                                    NavBarDropDownItem "Action" () 
                                    , NavBarDropDownItem "Another action" () 
                                    , NavBarDropDownItem "Something else here" () 
                                ])
                          ]
                          ( Search 
                            "Search"
                            (\s -> ())
                            ()
                          )
                        )
                        "Bootstrap starter template"
                        (Paragraphs [ 
                            "Use this document as a way to quickly start any new project."
                            , "All you get is this text and a mostly barebones HTML document." 
                        ])
            in
                toHtmlString masterPageType
                |> Html.toString 2 
                |> String.filter isBlackspace
                |> Expect.equal (String.filter isBlackspace """<div>
  <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" tab-index="1">
      Navbar
    </a>
    <button class="navbar-toggler" aria-label="Toggle navigation" aria-expanded="false" aria-controls="navbarsExampleDefault" data-target="#navbarsExampleDefault" data-toggle="collapse" type="button">
      <span class="navbar-toggler-icon">
      </span>
    </button>
    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link">
            Home
            <span class="sr-only">
              (current)
            </span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link">
            Link
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">
            Disabled
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" aria-expanded="false" aria-haspopup="true" data-toggle="dropdown" id="dropdown01">
            Dropdown
          </a>
          <div class="dropdown-menu" aria-labelledby="dropdown01">
            <a class="dropdown-item">
              Action
            </a>
            <a class="dropdown-item">
              Another action
            </a>
            <a class="dropdown-item">
              Something else here
            </a>
          </div>
        </li>
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2"  aria-label="Search" placeholder="Search" type="text">
        <button class="btn btn-outline-success my-2 my-sm-0" type="button">
          Search
        </button>
      </form>
    </div>
  </nav>
  <main class="container" role="main">
    <div class="starter-template">
      <h1>
        Bootstrap starter template
      </h1>
      <p>
        Use this document as a way to quickly start any new project.
      </p>
      <p>
        All you get is this text and a mostly barebones HTML document.
      </p>
    </div>
  </main>
</div>""" )

isBlackspace: Char -> Bool
isBlackspace char = 
  char /= ' ' && char /= '\n' && char /= '\r'
module BootstrapStarterTests exposing (..)

import Test exposing (..)
import Expect exposing (..)
import BootstrapStarter exposing (..)
import Html.String as Html exposing (Html)
--import Test.Html.Query as Query
--import Test.Html.Selector exposing (..)
--import Html.Attributes as Html

navBarDropDownItem : Test
navBarDropDownItem =
    test "navBarDropDownItem returns correct html" <|
        \() ->
            renderNavBarDropDownItem (NavBarDropDownItem "Action" "#") 
            |> Html.toString 0 
            |> Expect.equal """<a class="dropdown-item" href="#">Action</a>"""

navBarDropDown : Test
navBarDropDown =
    test "navBarDropDown returns correct html" <|
        \() ->
            renderNavBarDropDown 
              ( NavBarDropDown
                  "Title"
                  "dropdown01"
                  "http://example.com"
                  [ NavBarDropDownItem "Action" "#" ])
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Title</a><div class="dropdown-menu" aria-labelledby="dropdown01"><a class="dropdown-item" href="#">Action</a></div></li>""" 


navBarLinkVanillaSelected : Test
navBarLinkVanillaSelected =
    test "navBarVanilla returns correct html when selected" <|
        \() ->
            renderNavBarVanilla (NavBarVanilla "Home" "#" LinkStateSelected) 
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item active"><a class="nav-link" href="#">Home<span class="sr-only">(current)</span></a></li>"""


navBarLinkVanillaDisabled : Test
navBarLinkVanillaDisabled =
    test "navBarVanilla returns correct html when disabled" <|
        \() ->
            renderNavBarVanilla (NavBarVanilla "Disabled" "#" LinkStateDisabled) 
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a></li>"""

navBarLinkVanilla : Test
navBarLinkVanilla =
    test "navBarVanilla returns correct html when in vanilla state" <|
        \() ->
            renderNavBarVanilla (NavBarVanilla "Link" "#" LinkStateVanilla) 
            |> Html.toString 0 
            |> Expect.equal """<li class="nav-item"><a class="nav-link" href="#">Link</a></li>"""

navBarLinks : Test
navBarLinks =
    test "renderNavBarLinks returns correct html" <|
        \() ->
            renderNavBarLinks [ Vanilla <| NavBarVanilla "Link" "#" LinkStateVanilla ]
            |> Html.toString 0 
            |> Expect.equal """<ul class="navbar-nav mr-auto"><li class="nav-item"><a class="nav-link" href="#">Link</a></li></ul>"""
  
search : Test
search =
    test "renderSearch returns correct html" <|
        \() ->
            renderSearch "Search"
            |> Html.toString 0
            |> Expect.equal """<form class="form-inline my-2 my-lg-0"><input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search"><button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button></form>"""


navBar : Test
navBar =
    test "renderNavBar returns correct html" <|
        \() ->
            renderNavBar "Search" [ Vanilla <| NavBarVanilla "Link" "#" LinkStateVanilla ]
            |> Html.toString 2
            |> Expect.equal """<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="#">
    Navbar
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon">
    </span>
  </button>
  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#">
          Link
        </a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
        Search
      </button>
    </form>
  </div>
</nav>"""

pageTitleAndContentParagraphs : Test
pageTitleAndContentParagraphs =
    test "renderPageContent returns p tags for each paragraph" <|
        \() ->
            renderPageTitleAndContent "Header" ( Paragraphs [ "a", "b" ] )
            |> Html.toString 0
            |> Expect.equal """<main role="main" class="container"><div class="starter-template"><h1>Header</h1><p>a</p><p>b</p></div></main>"""

pageTitleAndContentCustom : Test
pageTitleAndContentCustom =
    test "renderPageContent returns passed custom content" <|
        \() ->
            renderPageTitleAndContent "Heading" (Custom <| [ Html.div [] [] ] )
            |> Html.toString 0
            |> Expect.equal """<main role="main" class="container"><div class="starter-template"><h1>Heading</h1><div></div></div></main>"""

-- add links to js files
endToEnd : Test
endToEnd =
    test "BootstrapStarter returns same html as bootstrap example page (https://getbootstrap.com/docs/4.0/examples/starter-template/)" <|
        \() ->
            let
                masterPageType = 
                    BootstrapStarter
                        "Navbar" 
                        [
                            Vanilla (NavBarVanilla "Home" "#" LinkStateSelected)
                            , Vanilla (NavBarVanilla "Link" "#" LinkStateVanilla)
                            , Vanilla (NavBarVanilla "Disabled" "#" LinkStateDisabled)
                            , DropDown (NavBarDropDown
                                "Dropdown"
                                "dropdown01"
                                "http://example.com"
                                [
                                    NavBarDropDownItem "Action" "#"
                                    , NavBarDropDownItem "Another action" "#"
                                    , NavBarDropDownItem "Something else here" "#"
                                ])
                        ]
                        "Search"
                        "Bootstrap starter template"
                        (Paragraphs [ 
                            "Use this document as a way to quickly start any new project."
                            , "All you get is this text and a mostly barebones HTML document." 
                        ])
            in
                renderPage masterPageType
                |> Html.toString 2 
                |> String.filter isBlackspace
                |> Expect.equal (String.filter isBlackspace """<div>
  <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="#">
      Navbar
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon">
      </span>
    </button>
    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="#">
            Home
            <span class="sr-only">
              (current)
            </span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">
            Link
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">
            Disabled
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Dropdown
          </a>
          <div class="dropdown-menu" aria-labelledby="dropdown01">
            <a class="dropdown-item" href="#">
              Action
            </a>
            <a class="dropdown-item" href="#">
              Another action
            </a>
            <a class="dropdown-item" href="#">
              Something else here
            </a>
          </div>
        </li>
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
          Search
        </button>
      </form>
    </div>
  </nav>
  <main role="main" class="container">
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
  char /= ' ' && char /= '\n'
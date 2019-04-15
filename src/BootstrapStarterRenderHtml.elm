module BootstrapStarterRenderHtml exposing (
    renderPage)

import Html exposing (Html)
import Html.String exposing (Html)
import BootstrapStarter exposing (..)
import BootstrapStarterRenderHtmlString exposing (renderPage)

renderPage: BootstrapStarter msg -> Html.Html msg
renderPage bootstrap =
    BootstrapStarterRenderHtml.renderPage bootStrap
    |> Html.String.toHtml

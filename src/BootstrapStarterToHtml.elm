module BootstrapStarterToHtml exposing (toHtml)

{-|

# Creating Html from a BootstrapStarter 
@docs toHtml

-}

import Html exposing (Html)
import Html.String exposing (Html)
import BootstrapStarter exposing (..)
import BootstrapStarterToHtmlString as BootstrapStarterToHtmlString exposing (toHtmlString)

{-| Convert a BootstrapStarter msg to Html msg
-}
toHtml: BootstrapStarter msg -> Html.Html msg
toHtml bootstrap =
    BootstrapStarterToHtmlString.toHtmlString bootstrap
    |> Html.String.toHtml

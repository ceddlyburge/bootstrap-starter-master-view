# Elm Master Page Type for "Bootstrap Starter"

This repo contains types and functions that represent the Bootstrap Starter template (https://getbootstrap.com/docs/4.3/examples/starter-template/)

## Usage

- Install the package
- Copy [starter-template.css](starter-template.css) from this repository, in to the `public` folder of your Elm application

- Add the following to the `<head>` of your index.html

```html
    <!-- Bootstrap core CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">    
    <!-- Bootstrap starter template CSS -->
    <link href="%PUBLIC_URL%/starter-template.css" rel="stylesheet" >
```

- Add the following at the end of the `<body>` (just before `<\body>`) of your index.html

```html
    <!-- Bootstrap scripts -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>    
```


- Create an instance of the BootstrapStarter type
- Pass this instance to `BootstrapStarterToHtml.toHtml`, which returns 'Html msg'

# Demo application

You can look at the [Demo Application](https://github.com/ceddlyburge/elm-bootstrap-starter-demo) to see how it all works, 


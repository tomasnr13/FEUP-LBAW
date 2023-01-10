<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Styles -->
    {{-- {{-- <link href="{{ asset('css/milligram.min.css') }}" rel="stylesheet">
    <link href="{{ asset('css/app.css') }}" rel="stylesheet"> --}}

    {{-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script nonce="f9716b72-5de5-4802-961b-6fba83a09c5a">(function(w,d){!function(eK,eL,eM,eN){eK.zarazData=eK.zarazData||{};eK.zarazData.executed=[];eK.zaraz={deferred:[],listeners:[]};eK.zaraz.q=[];eK.zaraz._f=function(eO){return function(){var eP=Array.prototype.slice.call(arguments);eK.zaraz.q.push({m:eO,a:eP})}};for(const eQ of["track","set","debug"])eK.zaraz[eQ]=eK.zaraz._f(eQ);eK.zaraz.init=()=>{var eR=eL.getElementsByTagName(eN)[0],eS=eL.createElement(eN),eT=eL.getElementsByTagName("title")[0];eT&&(eK.zarazData.t=eL.getElementsByTagName("title")[0].text);eK.zarazData.x=Math.random();eK.zarazData.w=eK.screen.width;eK.zarazData.h=eK.screen.height;eK.zarazData.j=eK.innerHeight;eK.zarazData.e=eK.innerWidth;eK.zarazData.l=eK.location.href;eK.zarazData.r=eL.referrer;eK.zarazData.k=eK.screen.colorDepth;eK.zarazData.n=eL.characterSet;eK.zarazData.o=(new Date).getTimezoneOffset();if(eK.dataLayer)for(const eX of Object.entries(Object.entries(dataLayer).reduce(((eY,eZ)=>({...eY[1],...eZ[1]})))))zaraz.set(eX[0],eX[1],{scope:"page"});eK.zarazData.q=[];for(;eK.zaraz.q.length;){const e_=eK.zaraz.q.shift();eK.zarazData.q.push(e_)}eS.defer=!0;for(const fa of[localStorage,sessionStorage])Object.keys(fa||{}).filter((fc=>fc.startsWith("_zaraz_"))).forEach((fb=>{try{eK.zarazData["z_"+fb.slice(7)]=JSON.parse(fa.getItem(fb))}catch{eK.zarazData["z_"+fb.slice(7)]=fa.getItem(fb)}}));eS.referrerPolicy="origin";eS.src="/cdn-cgi/zaraz/s.js?z="+btoa(encodeURIComponent(JSON.stringify(eK.zarazData)));eR.parentNode.insertBefore(eS,eR)};["complete","interactive"].includes(eL.readyState)?zaraz.init():eK.addEventListener("DOMContentLoaded",zaraz.init)}(w,d,0,"script");})(window,document);</script></head> --}}


    @isset($css)
    <link rel="stylesheet" type="text/css" href="{{ asset('css/' . $css) }}">
    @endisset

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    {{-- <script
    src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>


    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script> --}}

  </head>
  <body>
    <script>
      function showEditor(editButton) {
        editButton.style.display = "none";

        const comment = editButton.parentElement;
        const description = comment.querySelector(".description");
        description.style.display = "none";
        comment.querySelector(".timestamp").style.display = "none";
        comment.querySelector(".delete-form").style.display = "none";

        const editForm = comment.querySelector(".edit-form");
        editForm.querySelector("textarea").value = description.innerText;
        editForm.style.display = null;
      }

      function hideEditor(cancelButton) {
        const editForm = cancelButton.parentElement;
        editForm.style.display = "none";

        const comment = editForm.parentElement;
        comment.querySelector(".description").style.display = null;
        comment.querySelector(".timestamp").style.display = null;
        comment.querySelector(".edit-btn").style.display = null;
        comment.querySelector(".delete-form").style.display = null;
      }
    </script>
    <main>
      <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
          <a class="navbar-brand" href="{{ url('/') }}">
            <img src="https://i.ebayimg.com/images/g/W0oAAMXQHU1Rt3RJ/s-l500.jpg" width="60" height="60" class="d-inline-block align-top" alt="">
            <h2>Twira</h2>
          </a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <!-- Modal -->
          <div class="modal fade" id="modalpost" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="TituloModalCentralizado">Post Text</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>

                <div class="modal-body">
                  <form method="POST" action="{{ route('createPost') }}">
                    @csrf
                    <div style="text-align: center; bottom:50%; top:250px">
                        <label for="description">Write a new post:</label>
                        <textarea id="description" name="description" required autofocus></textarea>
                        <button type="submit">Submit</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <form class="form-inline" action="{{ route('search') }}" method="GET">
              <input class="form-control mr-sm-2" type="text" name="search" placeholder="Search" aria-label="Search">
              <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
            <ul class="navbar-nav mx-auto">
              @if (Auth::check())
              <li class="nav-item active">
                <a class="nav-link" href="fytimeline">FY <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item"><a href="{{ url('/') }}" class="nav-link">Public</a></li>
              <li class="nav-item"><a href="{{ url('/friendreqs') }}" class="nav-link">Requests</a></li>
              <li class="nav-item"><a href="#" class="nav-link">Messages</a></li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Create Post
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                  <a class="dropdown-item"  type="button" data-toggle="modal" data-target="#modalpost">Text</a>
                  <a class="dropdown-item" href="#">Photo</a>
                  <a class="dropdown-item" href="#">Video</a>
                </div>
              </li>
              @endif
              <li class="nav-item"><a href="{{ url('/profile/browse') }}" class="nav-link">Browse Profiles</a></li>
            </ul>
            <ul class="navbar-nav float-right">
              @if (Auth::check())
              <li class="nav-item"><a href="{{ url('/profile') }}" class="nav-link">My Profile</a></li>
              <li class="nav-item"><a href="{{ url('/account/logout') }}" class="nav-link">Logout</a></li>
              @else
                <li class="nav-item"><a href="{{ url('/account/login') }}" class="nav-link">Login</a></li>
                <li class="nav-item"><a href="{{ url('/account/register') }}" class="nav-link">Register</a></li>
              @endif
            </ul>
          </div>
        </nav>
      </header>
      
      <section id="content">
        @include('flash-message')
        @yield('content')
      </section>
    </main>
  </body>
  <footer class="text-center text-white fixed-bottom bg-dark" >
    <div class="p-3">
      <a class="text-white" href="about">About</a>
      <a class="text-white" href="#">FAQ</a>
      <a class="text-white" href="#">Support</a>
    </div>
    <!-- Copyright -->
  </footer>
</html>

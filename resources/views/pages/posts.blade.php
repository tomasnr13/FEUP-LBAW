@extends('layouts.app', ['css' => 'profiles.css'])

@section('title', "Posts")

@section('content')
    <div style="height:80%; width:100%; overflow:scroll">
        @if (Auth::check())
        <div style="position: absolute; border:solid black; width:18%; height:90%; float:left; border-radius: 25px; padding:5px;margin: 10px; overflow:scroll">
            <h1 style="text-align: center">Friends</h1>
        </div>
        <div style="border:solid black; width:18%; height:90%; float:right; border-radius: 25px; padding:5px;margin: 10px; overflow:scroll">
            <h1 style="text-align: center">Groups</h1>
        </div>
        @endif
        {{-- <div style="border: solid black; width:20%;margin:auto;text-align: center;margin-bottom:5px" onclick="window.location='/post/create'">
            Create Post
        </div> --}}
        @foreach ($posts as $post)
            @include('partials.post', ['post' => $post])
        @endforeach
    </div>
@endsection

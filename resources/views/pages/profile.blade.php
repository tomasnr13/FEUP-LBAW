@extends('layouts.app', ['css' => 'profile.css'])

@section('title', "{$profile_user->username}'s Profile")

@section('content')
    <div id="profile-page">
        <div id="profile-info">
            <p id="profile-name">{{ $profile_user->username }}</p>
        </div>
        <div id="profile-bio">
            <p id="profile-name">{{ $profile_user->bio }} </p>
        </div>
    </div>

    <div style="text-align:center">
        @if ($profile_user->id != Auth::id())
        <a href="{{ url('/validatefreq/' . $profile_user->id) }}">
            <span class="btn btn-primary">Add Friend</span>
        </a>
        <a href="{{ url('/validatedelfreq/' . $profile_user->id) }}">
            <span class="btn btn-danger">Remove Friend</span>
        </a>
        @endif
    </div>

    <div>
        @foreach($profile_user->postsByInverseChronologicalOrder as $post)
            @include('partials.post', ['post' => $post])
        @endforeach
    </div>
@endsection

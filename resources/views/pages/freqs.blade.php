@extends('layouts.app', ['css' => 'profiles.css'])

@section('title', "Friend Requests")

@section('content')
    @foreach ($users as $user)
        <div id="profile-page" onclick="window.location='/profile/{{ $user->id }}'">
            <div id="profile-info">
                {{ $user->username }}
                <a href="{{ url('/acceptfreq/' . $user->id) }}">
                    <span class="btn btn-primary">Accept</span>
                </a>
                <a href="{{ url('/denyfreq/' . $user->id) }}">
                    <span class="btn btn-danger">Deny</span>
                </a>
            </div>
        </div>
    @endforeach  
@endsection
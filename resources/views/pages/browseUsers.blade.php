@extends('layouts.app', ['css' => 'profiles.css'])

@section('title', "Public Profiles")

@section('content')
    @foreach ($users as $user)
        <div id="profile-page" onclick="window.location='/profile/{{ $user->id }}'">
            <div id="profile-info">
                {{ $user->username }}
            </div>
        </div>
    @endforeach  
@endsection
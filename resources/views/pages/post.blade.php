@extends('layouts.app', ['css' => 'profiles.css'])

@section('title', "Post")

@section('content')
    @include('partials.post', ['post' => $post])

    <form method="POST" action="{{ url('/post/' . $post->id . "/comment") }}">
        @csrf
        <div style="text-align: center; bottom:50%; top:250px">
            <label for="comment">Comment</label>
            <textarea id="comment" name="text" required autofocus></textarea>
            <button type="submit">Submit</button>
        </div>
    </form>

    @foreach($post->commentsByInverseChronologicalOrder as $comment)
        @include('partials.comment', ['comment' => $comment])
    @endforeach
@endsection

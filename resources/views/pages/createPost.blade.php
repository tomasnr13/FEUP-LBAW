@extends('layouts.app')
@section('content')
<form method="POST" action="{{ route('createPost') }}">
    @csrf
    <div style="text-align: center; bottom:50%; top:250px">
        <label for="description">Write a new post:</label>
        <textarea id="description" name="description" required autofocus></textarea>
        <button type="submit">Submit</button>
    </div>
</form>
@endsection

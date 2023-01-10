@extends('layouts.app')

@section('content')
<form method="POST" action="{{ route('login') }}">
    {{ csrf_field() }}
    <div style="background-color: rgb(227, 225, 225); position: absolute; left: 20%; top: 5%; width: 40%; border:solid black; border-radius: 25px; padding:50px; margin: 200px">
        <!-- Email input -->
        <h1 style="text-align:center">Login</h1>
        <div class="form-outline mb-4">
            <input id="username" class="form-control" type="text" name="username" value="{{ old('username') }}" required autofocus>
            <label class="form-label" for="username">Username</label>
            @if ($errors->has('username'))
            <span class="error">
                {{ $errors->first('username') }}
            </span>
            @endif
        </div>

        <!-- Password input -->
        <input id="password" class="form-control" type="password" name="password" required>
        <label class="form-label" for="password" >Password</label>
        @if ($errors->has('password'))
            <span class="error">
                {{ $errors->first('password') }}
            </span>
        @endif

        <!-- 2 column grid layout for inline styling -->
        <div class="row mb-4">
            <div class="col d-flex justify-content-center">
            <!-- Checkbox -->
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="remember" checked name="remember" {{ old('remember') ? 'checked' : '' }}/>
                <label class="form-check-label" for="remember"> Remember me </label>
            </div>
            </div>

            <div class="col">
            <!-- Simple link -->
            <a href="#!">Forgot password?</a>
            </div>
        </div>

        <!-- Submit button -->
        <button type="submit" class="btn btn-primary btn-block mb-4">Log in</button>

        <!-- Register buttons -->
        <div class="text-center">
            <p>Not a member? <a href="{{ route('register') }}">Register</a></p>
        </div>
    </div>
</form>
@endsection

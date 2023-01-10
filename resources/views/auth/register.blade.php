@extends('layouts.app')

@section('content')
<form method="POST" action="{{ route('register') }}">
    {{ csrf_field() }}
    <div style="background-color: rgb(227, 225, 225); position: absolute; left: 20%; top: 5%; width: 40%; border:solid black; border-radius: 25px; padding:50px; margin: 200px">
      <h1 style="text-align:center">Register</h1>
      
      <input id="username" class="form-control" type="text" name="username" value="{{ old('username') }}" required autofocus>
      <label for="username">Username</label>
      @if ($errors->has('username'))
        <span class="error">
            {{ $errors->first('username') }}
        </span>
      @endif

      <input id="email" class="form-control" type="email" name="email" value="{{ old('email') }}" required>
      <label for="email">E-Mail Address</label>
      @if ($errors->has('email'))
        <span class="error">
            {{ $errors->first('email') }}
        </span>
      @endif

      <input id="phone" class="form-control" type="text" name="phone" pattern="[0-9]{9}" value="{{ old('phone') }}" required>
      <label for="phone">Phone</label>
      @if ($errors->has('phone'))
        <span class="error">
            {{ $errors->first('phone') }}
        </span>
      @endif

      <input id="password" class="form-control" type="password" name="password" required>
      <label for="password">Password</label>
      @if ($errors->has('password'))
        <span class="error">
            {{ $errors->first('password') }}
        </span>
      @endif

      <input id="password-confirm" class="form-control" type="password" name="password_confirmation" required>
      <label for="password-confirm">Confirm Password</label>

      <input id="birthDate" class="form-control" type="date" name="birthDate" required>
      <label for="birthDate">Birth Date</label>

      <div class="row mb-4">
        <div class="col d-flex justify-content-center">
        <!-- Checkbox -->
        <div class="form-check">
            <input class="form-check-input" type="checkbox" value="" id="publicProfile" name="publicProfile"/>
            <label class="form-check-label" for="publicProfile"> Public Profile </label>
        </div>
        </div>
    </div>

    <button type="submit" class="btn btn-primary btn-block mb-4">Register</button>
    <!-- Register buttons -->
    <div class="text-center">
      <p>Already a member? <a href="{{ route('login') }}">Login</a></p>
    </div>
    </div>

</form>
@endsection

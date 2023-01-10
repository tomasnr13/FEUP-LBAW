<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use App\Models\User;

class UserController extends Controller
{
    /**
     * Shows the profile for a given user id.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id)
    {
        $profile = User::find($id);

        if (empty($profile)) {
            Flash::error('User not found');
        }


        echo "<script>console.log('Debug Objects: " . $id . "' );</script>";
        echo "<script>console.log('Debug Objects: " . $profile->username . "' );</script>";

        return view('pages.profile')->with('profile_user', $profile);
    }

    public function showSelf()
    {
        if(Auth::check()) {
            $user = Auth::user();
            return view('pages.profile')->with('profile_user', $user);
        } else {
            return redirect('/account/login');
        }
    }

    public function showPublic()
    {
        $publicUsers = User::where('public', 'Yes')->get();

        foreach ($publicUsers as $user) {
            echo "<script>console.log('Debug Objects: " . $user->username . "' );</script>";
        }

        return view('pages.browseUsers')->with('users', $publicUsers);
    }

    public function search(Request $request)
    {
        $search = $request->input('search');

        // Search in the title and body columns from the posts table
        $users = User::query()
            ->where('username', 'LIKE', "%{$search}%")
            ->orWhere('bio', 'LIKE', "%{$search}%")
            ->get();
    
        // Return the search view with the resluts compacted
        return view('pages.browseUsers')->with('users', $users);
    }
}

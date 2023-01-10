<?php

namespace App\Http\Controllers;

use App\Models\FriendRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use App\Models\Friend;

class FriendController extends Controller
{
    public function validatefreq($user_id)
    {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();

        $friends_rel = Friend::where('id_friend1',$user->id)->get();
        foreach ($friends_rel as $rel) {
            if ($user_id == $rel->id_friend2)
                return redirect('/profile/' . $user_id)->with('error','You are already friends!');;
        }
        
        $freq_rel = FriendRequest::where('id_sender',$user->id)->get();
        foreach ($freq_rel as $freq) {
            if ($user_id == $freq->id_receiver)
                return redirect('/profile/' . $user_id)->with('error','Already sent request!');;
        }

        $freq_rel = FriendRequest::where('id_receiver',$user->id)->get();
        foreach ($freq_rel as $freq) {
            if ($user_id == $freq->id_sender)
                $rel = FriendRequest::findOrFail($freq->id);
                $rel->delete();
        }

        return redirect('createfreq/' . $user_id);
    }

    public function create($user_id)
    {
        $user = Auth::user();

        $freq = FriendRequest::create([
            'id_sender' => $user->id,
            'id_receiver' => $user_id
        ]);

        $freq->save();
        return redirect('/profile/' . $user_id)->with('success','Friend request sent!');
    }

    public function accept($user_id)
    {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();

        $friend1 = Friend::create([
            'id_friend1' => $user->id,
            'id_friend2' => $user_id
        ]);

        $friend2 = Friend::create([
            'id_friend1' => $user_id,
            'id_friend2' => $user->id
        ]);

        $friend1->save();
        $friend2->save();
        return redirect('')->with('success','Friend request accepted!');
    }

    public function deny($user_id)
    {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();

        $freq_rel = FriendRequest::where('id_receiver',$user->id)->get();
        foreach ($freq_rel as $freq) {
            if ($user_id == $freq->id_sender)
                $rel = FriendRequest::findOrFail($freq->id);
                $rel->delete();
        }

        return redirect('')->with('success','Friend request denied!');
    }

    public function validatedelfreq($user_id)
    {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();

        $friends_rel = Friend::where('id_friend1',$user->id)->get();
        foreach ($friends_rel as $rel) {
            if ($user_id == $rel->id_friend2)
                return redirect('/remfriend/' . $rel->id . '/' . $user_id);
        }
        return redirect('/profile/' . $user_id)->with('error','Not your friend!');;
    }

    public function delete($rel_id, $user_id)
    {
        $friends_rel = Friend::findOrFail($rel_id);
        $friends_rel->delete();
        return redirect('/profile/' . $user_id)->with('success','Friend removed!');
    }

    public function showfreqs(){
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();

        $freq_rel = FriendRequest::where('id_receiver',$user->id)->get();
        $users = array();
        foreach ($freq_rel as $freq) {
            array_push($users,User::find($freq->id_sender));
        }

        return view('pages.freqs')->with('users', $users);
    }

}
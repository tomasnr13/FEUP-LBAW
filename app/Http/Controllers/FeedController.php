<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\GroupMember;
use App\Models\Friend;
use App\Models\User;
use App\Models\Group;
use App\Http\Controllers\Collection;
use App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class FeedController extends Controller
{
     /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/';

    public function show()
    {
        if (Auth::check()){
            $user = Auth::user();

            $posts = Post::all()->toQuery()->orderByDesc('date_of_post')->get();
            
            $friends_rel = Friend::where('id_friend1',$user->id)->get();
            $friends = array();
            foreach ($friends_rel as $rel) {
                array_push($friends,User::find($rel->id_friend2));
            }
            

            $groups_member = GroupMember::where('id_member', $user->id)->get();
            $groups = array();
            foreach ($groups_member as $gm) {
                array_push($groups,Group::find($gm->id_group));
            }

            echo "<script>console.log('Posts:');</script>";
            foreach ($posts as $post) {
                echo "<script>console.log('Debug Objects: " . $post->description . "' );</script>";
            }
            echo "<script>console.log('Friends:');</script>";
            foreach ($friends as $friend) {
                echo "<script>console.log('Debug Objects: " . $friend->username . "' );</script>";
            }
            echo "<script>console.log('Groups:');</script>";
            foreach ($groups as $group) {
                echo "<script>console.log('Debug Objects: " . $group->name . "' );</script>";
            }
            return view('pages.feed',['posts' => $posts, 'friends' => $friends, 'groups' => $groups ]);
        } else {
            return redirect('/account/login');
        }
    }

    public function showFy()
    {
        if (Auth::check()){
            $user = Auth::user();
            
            $friends_rel = Friend::where('id_friend1',$user->id)->get();
            $friends = array();
            foreach ($friends_rel as $rel) {
                array_push($friends,User::find($rel->id_friend2));
            }

            $posts = collect();
            foreach ($friends as $friend) {
                $posts = $posts->merge(Post::where('id_author',$friend->id)->get());
            }

            $groups_member = GroupMember::where('id_member', $user->id)->get();
            $groups = array();
            foreach ($groups_member as $gm) {
                array_push($groups,Group::find($gm->id_group));
            }

            echo "<script>console.log('Posts:');</script>";
            foreach ($posts as $post) {
                echo "<script>console.log('Debug Objects: " . $post->description . "' );</script>";
            }
            echo "<script>console.log('Friends:');</script>";
            foreach ($friends as $friend) {
                echo "<script>console.log('Debug Objects: " . $friend->username . "' );</script>";
            }
            echo "<script>console.log('Groups:');</script>";
            foreach ($groups as $group) {
                echo "<script>console.log('Debug Objects: " . $group->name . "' );</script>";
            }
            return view('pages.feed',['posts' => $posts, 'friends' => $friends, 'groups' => $groups ]);
        } else {
            return redirect('/account/login');
        }
    }
}

<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PostController extends Controller
{
     /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/';

    public function showSingle($id) {
        $post = Post::find($id);
        return view('pages.post')->with('post', $post);
    }

    public function showPublic()
    {
        $publicPosts = Post::all()->toQuery()->orderByDesc('date_of_post')->get();

        foreach ($publicPosts as $post) {
            echo "<script>console.log('Debug Objects: " . $post->description . "' );</script>";
            echo "<script>console.log('ID: " . Auth::id() . "' );</script>";
        }

        return view('pages.posts')->with('posts', $publicPosts, 'friends', [], 'groups', []);
    }

    public function showCreatePostPage()
    {
        if(Auth::check())
            return view('pages.createPost');
        else
            return redirect('/account/login');
    }

    /**
     * Create a new post.
     */
    protected function create(Request $request)
    {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();
        $post = Post::create([
            'id_author' => $user->id,
            'description' => $request->description,
            'type' => 'Text'
        ]);

        $post->save();
        return redirect('/post/' . $post->id);
    }

    protected function edit(Request $request, $id) {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();
        $post = Post::findOrFail($id);
        if ($post->id_author !== $user->id) {
            return response('Post does not belong to the logged in user', 403);
        }

        $post->description = $request->text;
        $post->save();

        return redirect('/post/' . $id);
    }

    protected function delete($id) {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();
        $post = Post::findOrFail($id);
        if ($post->id_author !== $user->id) {
            return response('Post does not belong to the logged in user', 403);
        }

        $post->delete();

        return redirect('/profile');
    }
}

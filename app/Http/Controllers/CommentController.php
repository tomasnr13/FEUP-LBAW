<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    /**
     * Create a new commment.
     */
    protected function create(Request $request, $post_id)
    {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();
        $comment = Comment::create([
            'id_comment_author' => $user->id,
            'id_post' => $post_id,
            'description' => $request->text,
        ]);

        $comment->save();
        return redirect('/post/' . $post_id);
    }

    protected function edit(Request $request, $post_id, $id) {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();
        $comment = Comment::findOrFail($id);
        if ($comment->id_comment_author !== $user->id) {
            return response('Comment does not belong to the logged in user', 403);
        }

        $comment->description = $request->text;
        $comment->save();

        return redirect('/post/' . $post_id);
    }

    protected function delete($post_id, $id) {
        if (!Auth::check()) {
            return redirect('/account/login');
        }

        $user = Auth::user();
        $comment = Comment::findOrFail($id);
        if ($comment->id_comment_author !== $user->id) {
            return response('Comment does not belong to the logged in user', 403);
        }

        $comment->delete();

        return redirect('/post/' . $post_id);
    }
}

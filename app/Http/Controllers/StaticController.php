<?php

namespace App\Http\Controllers;

class StaticController extends Controller
{
    public function show()
    {
        return view('pages.about');
    }
}

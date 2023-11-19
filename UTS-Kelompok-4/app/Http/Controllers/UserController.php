<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $user = new User();

        $user->name = $request->name;
        $user->email = $request->email;
        $user->nim = $request->nim;
        $user->nohp = $request->nohp;
        $user->password = bcrypt($request->password);

        $user->save();

        return response()->json(['message' => 'Registrasi Berhasil'],200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function getUserByEmail(string $email)
    {
        //

        $user = User::where('email', $email)
        ->get();

        return response()->json([
            'user' => $user,
        ]);
    }
}

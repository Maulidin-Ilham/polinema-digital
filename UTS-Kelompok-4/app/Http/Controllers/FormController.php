<?php

namespace App\Http\Controllers;

use App\Models\Responden;
use Illuminate\Http\Request;

class FormController extends Controller
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
        $responden = new Responden();
        $responden->age = $request->age;
        $responden->gpa = $request->gpa;
        $responden->year = $request->year;
        $responden->count = $request->count;
        $responden->gender = $request->gender;
        $responden->nationality = $request->nationality;
        $responden->genre = $request->genre;
        $responden->reports = $request->reports;

        $responden->save();

        return response()->json(['message' => 'Data Berhasil disimpan'],200);

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
}

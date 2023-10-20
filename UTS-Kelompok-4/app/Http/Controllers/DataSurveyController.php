<?php

namespace App\Http\Controllers;

use App\Models\Responden;
use Illuminate\Http\Request;

class DataSurveyController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $responden_count = Responden::count();
        $avg_age = Responden::average("age");
        $avg_gpa = Responden::average("gpa");

        return response()->json([
            "reponden_all" => $responden_count,
            'average_age' => $avg_age,
            'average_gpa' => $avg_gpa,
            'message' => 'Average age of respondents',
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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

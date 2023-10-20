<?php

namespace App\Http\Controllers;

use App\Models\Responden;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SurveyDataController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $total_responden = Responden::count();
        $genreCounts = Responden::select('genre', DB::raw('count(*) as count'))
            ->groupBy('genre')
            ->get();

        $genderCounts = Responden::select('gender', DB::raw('count(*) as count'))
            ->groupBy('gender')
            ->get();

        $nationalityCounts = Responden::select('nationality', DB::raw('count(*) as count'))
            ->groupBy('nationality')
            ->get();

        $averageAge = Responden::avg('age');
        $averageGpa = Responden::avg('gpa');

        return response()->json(["total_responden"=>$total_responden,"genre_counts" => $genreCounts,"gender_counts" => $genderCounts,"nationality_counts" => $nationalityCounts,"average_age"=> (int)  $averageAge,"average_gpa"=> (float)$averageGpa]);

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

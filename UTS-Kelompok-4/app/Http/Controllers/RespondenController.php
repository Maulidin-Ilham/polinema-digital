<?php

namespace App\Http\Controllers;

use App\Http\Resources\RespondenResource;
use App\Models\Responden;
use Illuminate\Http\Request;

class RespondenController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        return RespondenResource::collection(Responden::all());
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
    public function show(Responden $responden)
    {
        return new RespondenResource($responden);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Responden $responden)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Responden $responden)
    {
        //
    }
}

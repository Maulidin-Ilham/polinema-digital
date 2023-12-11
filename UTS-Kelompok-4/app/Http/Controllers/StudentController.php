<?php

namespace App\Http\Controllers;

use App\Models\student;
use App\Http\Requests\StorestudentRequest;
use App\Http\Requests\UpdatestudentRequest;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StorestudentRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(student $student)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(student $student)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatestudentRequest $request, student $student)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(student $student)
    {
        //
    }

    public function dashboard()
    {
        // Retrieve respondents with the specified nationality
        $allStudent = student::all();
        $countAllStudent = $allStudent->count();

        $studentLulus = student::where('status_akhir', 1)->get();
        $countStudentLulus = $studentLulus->count();

        $studentTidakLulus = student::where('status_akhir', 0)->get();
        $countStudentTidakLulus = $studentTidakLulus->count();

        $persentageLulus = round(($countStudentLulus / $countAllStudent) * 100, 2);
        $persentageTidakLulus = round(($countStudentTidakLulus / $countAllStudent) * 100, 2);

        $avg_ipk2018 = student::average("ipk_2018");
        $avg_ipk2018 = floatval(number_format($avg_ipk2018, 2));

        $avg_ipk2019 = student::average("ipk_2019");
        $avg_ipk2019 = floatval(number_format($avg_ipk2019, 2));
        
        $avg_ipk2020 = student::average("ipk_2020");
        $avg_ipk2020 = floatval(number_format($avg_ipk2020, 2));

        $avg_ipk2021 = student::average("ipk_2021");
        $avg_ipk2021 = floatval(number_format($avg_ipk2021, 2));
        
        return response()->json([
            'allStudent' => $countAllStudent,
            'studentLulus' => $persentageLulus,
            'studentTidakLulus' => $persentageTidakLulus,
            'ipk2018' => $avg_ipk2018,
            'ipk2019' => $avg_ipk2019,
            'ipk2020' => $avg_ipk2020,
            'ipk2021' => $avg_ipk2021,
        ]);
    }
}

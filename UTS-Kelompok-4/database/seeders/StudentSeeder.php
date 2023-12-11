<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use League\Csv\Reader;

class StudentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //

        $csvStudent = Reader::createFromPath('public/akademik_clean.csv', 'r');
        $csvStudent->setHeaderOffset(0);

        foreach ($csvStudent as $student) {
            DB::table('students')->insert([
                'nim' => $student['nim'],
                'status_akhir' => $student['status_akhir'],
                'ipk_2018' => $student['2018'],
                'ipk_2019' => $student['2019'],
                'ipk_2020' => $student['2020'],
                'ipk_2021' => $student['2021'],
            ]);
        }
    }
}

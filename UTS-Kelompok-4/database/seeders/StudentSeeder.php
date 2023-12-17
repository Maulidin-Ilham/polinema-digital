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
        // membaca data csv untuk dimasukkan ke dalam database sebagai data default
        $csvStudent = Reader::createFromPath('public/akademik_clean.csv', 'r'); // membaca CSV yang ada di direktori Public dengan nama akademik_clean.csv
        $csvStudent->setHeaderOffset(0); // mendefinisikan baris pertama sebagai header/nama kolom (bukan real data)

        // perulangan untuk memasukkan tiap data ke dalam database
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

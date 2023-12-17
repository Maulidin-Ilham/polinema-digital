<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('students', function (Blueprint $table) {
            $table->id();
            $table->string('nim')->unique();
            $table->boolean('status_akhir'); // mahasiswa sudah lulus atau belum
            $table->float('ipk_2018'); // ipk mahasiswa x tahun 2018
            $table->float('ipk_2019'); // ipk mahasiswa x tahun 2019
            $table->float('ipk_2020'); // ipk mahasiswa x tahun 2020
            $table->float('ipk_2021'); // ipk mahasiswa x tahun 2021
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};

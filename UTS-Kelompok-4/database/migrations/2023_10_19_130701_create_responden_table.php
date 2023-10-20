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
        Schema::create('Respondens', function (Blueprint $table) {
            $table->id();
            // $table->string("name");
            $table->integer("age");
            $table->enum("gender",["M","F"]);
            $table->string("nationality");
            $table->float("gpa");
            $table->string("genre");
            $table->string("reports");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Respondens');
    }
};

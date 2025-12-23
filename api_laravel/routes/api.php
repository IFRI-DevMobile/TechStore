<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ArticleController;
use Illuminate\Support\Facades\Route;

// Routes publiques
Route::prefix('auth')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);
});

// Routes protégées par authentification
Route::middleware('auth:sanctum')->group(function () {
    // Routes d'authentification
    Route::prefix('auth')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/user', [AuthController::class, 'user']);
    });

    // Routes pour les articles
    Route::apiResource('articles', ArticleController::class);
    
    // Route supplémentaire pour les articles de l'utilisateur
    Route::get('/user/articles', [ArticleController::class, 'userArticles']);
});

// Routes publiques pour voir les articles
Route::get('/articles', [ArticleController::class, 'index']);
Route::get('/articles/{id}', [ArticleController::class, 'show']);
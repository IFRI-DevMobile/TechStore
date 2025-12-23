<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Article;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ArticleController extends Controller
{
    /**
     * Afficher tous les articles
     */
    public function index()
    {
        $articles = Article::with('user')->get();
        
        return response()->json([
            'articles' => $articles
        ]);
    }

    /**
     * Afficher un article spécifique
     */
    public function show($id)
    {
        $article = Article::with('user')->find($id);
        
        if (!$article) {
            return response()->json([
                'message' => 'Article not found'
            ], 404);
        }

        return response()->json([
            'article' => $article
        ]);
    }

    /**
     * Créer un nouvel article
     */
    public function store(Request $request)
    {
        
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
        ]);

        $article = Article::create([
            'title' => $request->title,
            'content' => $request->input('content'),
            'user_id' => Auth::id(),
        ]);

        return response()->json([
            'message' => 'Article created successfully',
            'article' => $article->load('user')
        ], 201);
    }

    /**
     * Mettre à jour un article
     */
    public function update(Request $request, $id)
    {
        $article = Article::find($id);
        
        if (!$article) {
            return response()->json([
                'message' => 'Article not found'
            ], 404);
        }

        // Vérifier que l'utilisateur est le propriétaire
        if ($article->user_id !== Auth::id()) {
            return response()->json([
                'message' => 'Unauthorized'
            ], 403);
        }

        $request->validate([
            'title' => 'sometimes|string|max:255',
            'content' => 'sometimes|string',
        ]);

        $article->update($request->only(['title', 'content']));

        return response()->json([
            'message' => 'Article updated successfully',
            'article' => $article->load('user')
        ]);
    }

    /**
     * Supprimer un article
     */
    public function destroy($id)
    {
        $article = Article::find($id);
        
        if (!$article) {
            return response()->json([
                'message' => 'Article not found'
            ], 404);
        }

        // Vérifier que l'utilisateur est le propriétaire
        if ($article->user_id !== Auth::id()) {
            return response()->json([
                'message' => 'Unauthorized'
            ], 403);
        }

        $article->delete();

        return response()->json([
            'message' => 'Article deleted successfully'
        ]);
    }

    /**
     * Articles de l'utilisateur connecté
     */
    public function userArticles()
    {
        $articles = Article::where('user_id', Auth::id())->get();
        
        return response()->json([
            'articles' => $articles
        ]);
    }
}
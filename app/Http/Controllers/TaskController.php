<?php
namespace App\Http\Controllers;

use App\Models\Project;
use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class TaskController extends Controller
{
    public function index(Project $project = null)
    {
        // Si un projet est fourni, affiche les tâches de ce projet
        if ($project) {
            $tasks = $project->tasks()->get()->groupBy('status');
            $users = $project->users()->get();  
            return view('tasks.index', compact('project', 'tasks', 'users'));
        }
        
        // Si aucun projet n'est fourni, affiche toutes les tâches de l'utilisateur actuel
        $user = Auth::user();
        $tasks = $user->tasks()->get()->groupBy('status');
        return view('tasks.index', compact('tasks'));
    }

    public function store(Request $request, Project $project)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'due_date' => 'nullable|date',
            'priority' => 'required|in:low,medium,high',
        ]);

        $project->tasks()->create($request->all());

        return redirect()->route('projects.tasks.index', $project)->with('success', 'Task created successfully.');
    }

    public function show(Task $task)
    {
        return view('tasks.show', compact('task'));
    }

    public function update(Request $request, Task $task)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'due_date' => 'nullable|date',
            'priority' => 'required|in:low,medium,high',
            'status' => 'required|in:to_do,in_progress,completed',
        ]);

        $task->update($request->all());

        return redirect()->route('projects.tasks.index', $task->project_id)->with('success', 'Task updated successfully.');
    }

    public function updateStatus(Request $request, Task $task)
    {
        $task->status = $request->input('status');
        $task->save();

        return response()->json(['message' => 'Task status updated successfully.']);
    }

    public function toggleComplete(Task $task)
    {
        $wasCompleted = $task->status === 'completed';
        
        $task->status = $wasCompleted ? 'to_do' : 'completed';
        $task->completed_at = $wasCompleted ? null : now();
        $task->save();
        
        return response()->json([
            'success' => true,
            'message' => $wasCompleted ? 'La tâche a été marquée comme à faire.' : 'La tâche a été marquée comme terminée.',
            'status' => $task->status,
            'completed_at' => $task->completed_at
        ]);
    }
}

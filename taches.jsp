<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<title>Taches</title>
</head>
<body bgcolor=white>


    <h1>Liste des tâches</h1>
    <%
        HttpSession session = request.getSession();
        ArrayList<Task> taskList = (ArrayList<Task>) session.getAttribute("taskList");
        if (taskList != null && !taskList.isEmpty()) {
            for (Task task : taskList) {
    %>
                <p>
                    <strong>Titre :</strong> <%= task.getTitle() %><br>
                    <strong>Description :</strong> <%= task.getDescription() %><br>
                    <strong>Date d'échéance :</strong> <%= task.getDueDate() %><br>
                    <strong>Statut :</strong> <%= task.isCompleted() ? "Terminée" : "Non terminée" %><br>
                    <a href="completeTask?id=<%= taskList.indexOf(task) %>">Marquer comme terminée</a><br>

<a href="deleteTask?id=<%= taskList.indexOf(task) %>">Supprimer</a>
                </p>
    <%
            }
        } else {
    %>
            <p>Aucune tâche à afficher.</p>
    <%
        }
    %>
    <a href="index.jsp">Retour à l'accueil</a

    <form action="addTask" method="post">
        <label for="title">Titre :</label>
        <input type="text" id="title" name="title" required><br>
        <label for="description">Description :</label>
        <textarea id="description" name="description" required></textarea><br>
        <label for="dueDate">Date d'échéance :</label>
        <input type="date" id="dueDate" name="dueDate" required><br>
        <input type="submit" value="Ajouter">
    </form>
    <a href="index.jsp">Retour à l'accueil</a>
<%! 
 public class Task {
    private String title;
    private String description;
    private String dueDate;
    private boolean isCompleted;

    public Task(String title, String description, String dueDate, boolean isCompleted) {
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.isCompleted = isCompleted;
    }

    // Getters and setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean isCompleted) {
        this.isCompleted = isCompleted;
    }
}

%>

<%
    String valeur = request.getParameter("valeur");

    if (valeur != null && !valeur.isEmpty()) {
        MyClass tache = new MyClass(valeur);
%>
        <p>Nom de la tâche : <%= tache.nameTache %></p>
<%
    }
%>

</body>
</html>
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
               HttpSession session = request.getSession();
        ArrayList<Task> taskList = (ArrayList<Task>) session.getAttribute("taskList");
        if (taskList == null) {
            taskList = new ArrayList<>();
        }
        taskList.add(newTask);
        session.setAttribute("taskList", taskList);

        response.sendRedirect("viewTasks.jsp");
    }
}
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/completeTask")
public class CompleteTaskServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        ArrayList<Task> taskList = (ArrayList<Task>) session.getAttribute("taskList");
        if (taskList != null && id >= 0 && id < taskList.size()) {
            Task task = taskList.get(id);
            task.setCompleted(true);
            session.setAttribute("taskList", taskList);
        }

        response.sendRedirect("viewTasks.jsp");
    }
}

@WebServlet("/deleteTask")
public class DeleteTaskServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        ArrayList<Task> taskList = (ArrayList<Task>) session.getAttribute("taskList");
        if (taskList != null && id >= 0 && id < taskList.size()) {
            taskList.remove(id);
            session.setAttribute("taskList", taskList);
        }

        response.sendRedirect("viewTasks.jsp");
    }
}



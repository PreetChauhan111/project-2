const express = require("express");
const app = express();
const PORT = 80; // use 80 in EC2 if needed

// Change this later to your API Gateway domain
const API_BASE = "http://api.preetchauhan211.in";

app.use(express.json());

// ✅ Health check for ALB
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// ✅ Frontend UI
app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>Library App</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
          }

          .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
          }

          h1 {
            text-align: center;
          }

          .form {
            margin-top: 20px;
          }

          input {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
          }

          button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
          }

          .add-btn {
            background: #28a745;
            color: white;
          }

          .refresh-btn {
            background: #007bff;
            color: white;
          }

          .delete-btn {
            background: #dc3545;
            color: white;
          }

          table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
          }

          th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
          }

          th {
            background: #f1f1f1;
          }

          tr:hover {
            background: #f9f9f9;
          }
        </style>
      </head>

      <body>
        <div class="container">
          <h1>📚 Library Management</h1>
          <div class="form">
            <input id="name" placeholder="Book Name" />
            <input id="author" placeholder="Author" />
            <input id="publish_date" type="date" />
            <button class="add-btn" onclick="addBook()">Add Book</button>
            <button class="refresh-btn" onclick="loadBooks()">Refresh</button>
          </div>

          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Name</th>
                <th>Author</th>
                <th>Publish Date</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody id="bookTable"></tbody>
          </table>
        </div>

        <script>
          const API = "${API_BASE}";

          async function loadBooks() {
            try {
              const res = await fetch(API + "/read");
              const data = await res.json();

              const table = document.getElementById("bookTable");
              table.innerHTML = "";

              data.forEach((book, index) => {
                const row = document.createElement("tr");

                row.innerHTML = \`
                  <td>\${index + 1}</td>
                  <td>\${book.name}</td>
                  <td>\${book.author}</td>
                  <td>\${book.publish_date}</td>
                  <td>
                    <button class="delete-btn" onclick="deleteBook('\${book.id}')">
                      Delete
                    </button>
                  </td>
                \`;

                table.appendChild(row);
              });
            } catch (err) {
              alert("Error loading books");
              console.error(err);
            }
          }

          async function addBook() {
            const name = document.getElementById("name").value;
            const author = document.getElementById("author").value;
            const publish_date = document.getElementById("publish_date").value;

            if (!name || !author || !publish_date) {
              alert("All fields are required");
              return;
            }

            try {
              await fetch(API + "/add", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                  name,
                  author,
                  publish_date
                })
              });

              // clear inputs
              document.getElementById("name").value = "";
              document.getElementById("author").value = "";
              document.getElementById("publish_date").value = "";

              loadBooks();
            } catch (err) {
              alert("Error adding book");
              console.error(err);
            }
          }

          async function deleteBook(id) {
            try {
              await fetch(API + "/delete", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ id })
              });

              loadBooks();
            } catch (err) {
              alert("Error deleting book");
              console.error(err);
            }
          }

          // Load on page start
          loadBooks();
        </script>
      </body>
    </html>
  `);
});

// ✅ Start server
app.listen(PORT, () => {
  console.log("Server running on port " + PORT);
});
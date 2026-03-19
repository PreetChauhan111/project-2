const express = require("express");
const app = express();
const PORT = 80;

// Configurable API base
const API_BASE = process.env.API_BASE || "https://api.preetchauhan211.in";

app.use(express.json());

// Health check
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// Frontend UI
app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>Library App</title>
        <style>
          body { font-family: Arial; background: #f4f6f8; }
          .container { max-width: 900px; margin: 40px auto; background: white; padding: 25px; border-radius: 10px; }
          input { padding: 10px; margin: 5px; }
          button { padding: 10px; margin: 5px; cursor: pointer; }
          table { width: 100%; margin-top: 20px; }
        </style>
      </head>

      <body>
        <div class="container">
          <h1>📚 Library Management</h1>

          <input id="name" placeholder="Book Name" />
          <input id="author" placeholder="Author" />
          <input id="publish_date" type="date" />

          <button onclick="addBook()">Add</button>
          <button onclick="loadBooks()">Refresh</button>

          <table border="1">
            <thead>
              <tr>
                <th>#</th>
                <th>Name</th>
                <th>Author</th>
                <th>Date</th>
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
              const res = await fetch(API + "/"); // FIXED
              if (!res.ok) throw new Error("API error");

              const data = await res.json();
              const table = document.getElementById("bookTable");
              table.innerHTML = "";

              data.forEach((book, i) => {
                table.innerHTML += \`
                  <tr>
                    <td>\${i + 1}</td>
                    <td>\${book.name}</td>
                    <td>\${book.author}</td>
                    <td>\${book.publish_date}</td>
                    <td>
                      <button onclick="deleteBook('\${book.id}')">Delete</button>
                    </td>
                  </tr>
                \`;
              });

            } catch (err) {
              alert("Error loading books");
              console.error(err);
            }
          }

          async function addBook() {
            const name = document.getElementById("name").value.trim();
            const author = document.getElementById("author").value.trim();
            const publish_date = document.getElementById("publish_date").value;

            if (!name || !author || !publish_date) {
              alert("All fields required");
              return;
            }

            try {
              await fetch(API + "/add", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                  id: Date.now().toString(), // FIXED
                  name,
                  author,
                  publish_date
                })
              });

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
                method: "DELETE", // FIXED
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ id })
              });

              loadBooks();

            } catch (err) {
              alert("Error deleting book");
              console.error(err);
            }
          }

          loadBooks();
        </script>
      </body>
    </html>
  `);
});

// Start server
app.listen(PORT, () => {
  console.log("Server running on port " + PORT);
});
const express = require("express");
const app = express();
const PORT = 80;

// Change this later if needed
const API_BASE = "http://api.preetchauhan211.in";

app.use(express.json());

// Health check (for ALB)
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// Serve frontend page
app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>Library App</title>
      </head>
      <body>
        <h1>📚 Library Management</h1>

        <h3>Add Book</h3>
        <input id="bookName" placeholder="Book Name"/>
        <button onclick="addBook()">Add</button>

        <h3>Books</h3>
        <button onclick="loadBooks()">Refresh</button>
        <ul id="bookList"></ul>

        <script>
          const API = "${API_BASE}";

          async function loadBooks() {
            const res = await fetch(API + "/read");
            const data = await res.json();

            const list = document.getElementById("bookList");
            list.innerHTML = "";

            data.forEach(book => {
              const li = document.createElement("li");
              li.innerHTML = book.name + 
                " <button onclick='deleteBook(\"" + book.id + "\")'>Delete</button>";
              list.appendChild(li);
            });
          }

          async function addBook() {
            const name = document.getElementById("bookName").value;

            await fetch(API + "/add", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ name })
            });

            loadBooks();
          }

          async function deleteBook(id) {
            await fetch(API + "/delete", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ id })
            });

            loadBooks();
          }

          loadBooks();
        </script>
      </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log("Server running on port " + PORT);
});
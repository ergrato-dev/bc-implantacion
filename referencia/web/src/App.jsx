import { useEffect, useState } from "react";

const vacio = { isbn: "", titulo: "", autor: "", anio: "" };

export default function App() {
  const [libros, setLibros] = useState([]);
  const [version, setVersion] = useState("…");
  const [form, setForm] = useState(vacio);
  const [error, setError] = useState("");

  async function cargar() {
    const respuesta = await fetch("/api/libros");
    setLibros(await respuesta.json());
  }

  useEffect(() => {
    cargar();
    fetch("/api/version").then((r) => r.json()).then((d) => setVersion(d.version));
  }, []);

  async function guardar(evento) {
    evento.preventDefault();
    setError("");
    const respuesta = await fetch("/api/libros", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ ...form, anio: Number(form.anio) }),
    });
    if (!respuesta.ok) {
      const cuerpo = await respuesta.json();
      setError(typeof cuerpo.detail === "string" ? cuerpo.detail : "Datos inválidos");
      return;
    }
    setForm(vacio);
    cargar();
  }

  const campo = (nombre) => ({
    name: nombre,
    value: form[nombre],
    onChange: (e) => setForm({ ...form, [nombre]: e.target.value }),
    required: true,
  });

  return (
    <main style={{ fontFamily: "system-ui, sans-serif", maxWidth: 720, margin: "2rem auto", padding: "0 1rem" }}>
      <h1>Biblioteca</h1>
      <p>Versión desplegada: <strong>{version}</strong></p>

      <form onSubmit={guardar} style={{ display: "grid", gap: "0.5rem", marginBottom: "1.5rem" }}>
        <input placeholder="ISBN" {...campo("isbn")} />
        <input placeholder="Título" {...campo("titulo")} />
        <input placeholder="Autor" {...campo("autor")} />
        <input placeholder="Año" type="number" {...campo("anio")} />
        <button type="submit">Agregar libro</button>
        {error && <p role="alert" style={{ color: "crimson" }}>{error}</p>}
      </form>

      <table style={{ width: "100%", borderCollapse: "collapse" }}>
        <thead>
          <tr><th align="left">ISBN</th><th align="left">Título</th><th align="left">Autor</th><th align="left">Año</th></tr>
        </thead>
        <tbody>
          {libros.map((l) => (
            <tr key={l.id}><td>{l.isbn}</td><td>{l.titulo}</td><td>{l.autor}</td><td>{l.anio}</td></tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}

const clients = [
  {
    name: "Ana Rodriguez",
    company: "Proceso personal",
    program: "10 escalones",
    status: "Activo",
    next: "Jueves 18:30",
    progress: "42%",
    notes: "Trabajar delegacion, limites y priorizacion semanal.",
    materials: "Mapa de objetivos, Plan semanal, Fortalezas",
  },
  {
    name: "Campo Norte",
    company: "Empresa agro",
    program: "AgroMENTORING",
    status: "Diagnostico",
    next: "Viernes 09:00",
    progress: "18%",
    notes: "Relevar roles de encargados y puntos de friccion operativa.",
    materials: "Encuesta inicial, Guia de entrevistas",
  },
  {
    name: "Sofia Pereira",
    company: "Proceso personal",
    program: "10 escalones",
    status: "Seguimiento",
    next: "Lunes 12:00",
    progress: "76%",
    notes: "Cerrar plan de 30 dias y revisar conversaciones pendientes.",
    materials: "Plan de accion, Registro de avances",
  },
  {
    name: "Equipo Comercial Sur",
    company: "Corporativo",
    program: "Mandos medios",
    status: "Activo",
    next: "Martes 15:00",
    progress: "55%",
    notes: "Alinear responsabilidades y preparar sesion grupal.",
    materials: "Canvas de roles, Guia de feedback",
  },
];

const loginDialog = document.querySelector("#loginDialog");
const portal = document.querySelector("#portal");
const portalRole = document.querySelector("#portalRole");
const portalTitle = document.querySelector("#portalTitle");
const clientView = document.querySelector('[data-view="client"]');
const adminView = document.querySelector('[data-view="admin"]');
const table = document.querySelector("#clientTable");
const detail = document.querySelector("#clientDetail");
const search = document.querySelector("#clientSearch");

function openLogin() {
  if (typeof loginDialog.showModal === "function") {
    loginDialog.showModal();
  }
}

function setRole(role) {
  portal.classList.remove("hidden");
  if (loginDialog.open) {
    loginDialog.close();
  }
  const isAdmin = role === "admin";
  portalRole.textContent = isAdmin ? "Backoffice privado" : "Portal del participante";
  portalTitle.textContent = isAdmin ? "Panel de Lourdes" : "Mi camino de excelencia";
  clientView.classList.toggle("hidden", isAdmin);
  adminView.classList.toggle("hidden", !isAdmin);
  portal.scrollIntoView({ behavior: "smooth", block: "start" });
  if (isAdmin) {
    renderClients(clients);
    renderDetail(clients[0]);
  }
}

function renderClients(items) {
  table.innerHTML = "";
  items.forEach((client, index) => {
    const row = document.createElement("button");
    row.type = "button";
    row.className = `client-row${index === 0 ? " active" : ""}`;
    row.innerHTML = `
      <strong>${client.name}<span>${client.company}</span></strong>
      <span>${client.program}</span>
      <span>${client.status}</span>
      <span>${client.next}</span>
    `;
    row.addEventListener("click", () => {
      document.querySelectorAll(".client-row").forEach((item) => item.classList.remove("active"));
      row.classList.add("active");
      renderDetail(client);
    });
    table.appendChild(row);
  });
}

function renderDetail(client) {
  detail.innerHTML = `
    <span class="status-pill">${client.status}</span>
    <h3>${client.name}</h3>
    <p>${client.company} · ${client.program}</p>
    <dl>
      <div><dt>Proxima sesion</dt><dd>${client.next}</dd></div>
      <div><dt>Progreso</dt><dd>${client.progress}</dd></div>
      <div><dt>Notas privadas</dt><dd>${client.notes}</dd></div>
      <div><dt>Materiales asignados</dt><dd>${client.materials}</dd></div>
    </dl>
  `;
}

document.querySelectorAll("[data-open-login]").forEach((button) => {
  button.addEventListener("click", openLogin);
});

document.querySelectorAll("[data-login-as]").forEach((button) => {
  button.addEventListener("click", () => setRole(button.dataset.loginAs));
});

document.querySelector("[data-logout]").addEventListener("click", () => {
  portal.classList.add("hidden");
  document.querySelector("#privado").scrollIntoView({ behavior: "smooth", block: "start" });
});

search.addEventListener("input", () => {
  const term = search.value.toLowerCase();
  const filtered = clients.filter((client) =>
    [client.name, client.company, client.program, client.status].join(" ").toLowerCase().includes(term)
  );
  renderClients(filtered);
  renderDetail(filtered[0] || {
    name: "Sin resultados",
    company: "Ajusta la busqueda",
    program: "",
    status: "Busqueda",
    next: "-",
    progress: "-",
    notes: "No hay clientes que coincidan con ese criterio.",
    materials: "-",
  });
});

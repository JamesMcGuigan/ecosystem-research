import { greeter_backend } from "../../declarations/greeter_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");
  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const name = document.getElementById("name").value.toString();

  // Avoid race condition by calling sequentially
  document.getElementById("greeting").innerText = await greeter_backend.greet(name);
  document.getElementById("count").innerText    = String(await greeter_backend.get_count());

  button.removeAttribute("disabled");
  return false;
});

window.onload = function() {
  greeter_backend.get_count().then(count => {
    document.getElementById("count").innerText = count;
  })
}

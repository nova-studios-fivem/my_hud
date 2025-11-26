function safe(v) {
    if (v === undefined || v === null || isNaN(v)) return 0;
    return Math.floor(v);
}

window.addEventListener('message', function (event) {
        const data = event.data;

    if (data.action === "setHudSide") {
        const hud = document.getElementById("hud");

        if (data.mode === "center") {
            hud.classList.add("hud-center");
            hud.classList.remove("hud-left");
        } else {
            hud.classList.add("hud-left");
            hud.classList.remove("hud-center");
        }
    }

    if (data.action === 'toggle') {
        document.getElementById('hud').classList.toggle('hidden', !data.show);
    }

    if (data.action === 'updateStatus') {
        document.getElementById('healthVal').textContent = safe(data.health);
        document.getElementById('armorVal').textContent = safe(data.armor);
        document.getElementById('hungerVal').textContent = safe(data.hunger);
        document.getElementById('thirstVal').textContent = safe(data.thirst);
        document.getElementById('staminaVal').textContent = safe(data.stamina);
    }
});

window.addEventListener("load", () => {
    fetch(`https://${GetParentResourceName()}/ready`, {
        method: "POST",
        body: "{}"
    });
});



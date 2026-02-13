    let items = [];
    let filteredItems = [];
    let selectedItem = null;

    window.addEventListener('message', (event) => {
        if (event.data.action === 'openBbqMenu') {
            items = event.data.items || [];
            filteredItems = [...items];
            selectedItem = null;

            document.getElementById('bbqMenu').classList.remove('hidden');
            uuendaItems();
            peidaValitudPanel();
        }
    });

    function sulgeMenu() {
        document.getElementById('bbqMenu').classList.add('hidden');

        fetch(`https://${GetParentResourceName()}/closeMenu`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        });
    }

    function uuendaItems() {
        const container = document.getElementById('itemsContainer');
        container.innerHTML = '';

        document.getElementById('itemCount').innerText =
            `${filteredItems.length}/${items.length}`;

        if (filteredItems.length === 0) {
            container.innerHTML =
                '<div class="col-span-2 text-center py-8 text-gray-400">Puudub!</div>';
            return;
        }

        filteredItems.forEach(item => {
            const div = document.createElement('div');
            div.className =
                'bg-slate-700/50 border border-slate-600 rounded-lg p-3 cursor-pointer hover:border-orange-500';
            div.onclick = () => valiItem(item);

            div.innerHTML = `
                <div class="flex justify-between">
                    <h3 class="text-white font-bold">${item.label}</h3>
                    <span class="text-xs bg-gray-400 px-2 py-1 rounded">${item.count} tk</span>
                </div>
                <div class="text-sm text-gray-400 mt-1">
                    ⏱️ ${(item.time / 1000).toFixed(1)}s
                </div>
            `;

            container.appendChild(div);
        });
    }

    function filtreeriItems() {
        const search = document.getElementById('searchInput').value.toLowerCase();
        filteredItems = !search
            ? [...items]
            : items.filter(i => i.label.toLowerCase().includes(search));
        uuendaItems();
    }

    function valiItem(item) {
        selectedItem = item;

        document.getElementById('selectedLabel').innerText = item.label;
        document.getElementById('selectedCount').innerHTML =
            `Taskus: <b>${item.count}</b> tk`;

        document.getElementById('selectedPanel').classList.remove('hidden');
    }

    function tyhjendaValik() {
        selectedItem = null;
        peidaValitudPanel();
    }

    function peidaValitudPanel() {
        document.getElementById('selectedPanel').classList.add('hidden');
    }

        function alustaGrillimist() {
            if (!selectedItem || selectedItem.count <= 0) return;
            fetch(`https://${GetParentResourceName()}/closeMenu`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });

            fetch(`https://${GetParentResourceName()}/selectItem`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    itemName: selectedItem.name
                })
            });

            document.getElementById('bbqMenu').classList.add('hidden');

            selectedItem = null;
        }

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            sulgeMenu();
        }
    });
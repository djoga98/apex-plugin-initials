let Initials = (function() {
	let colors = ["#1abc9c", "#16a085", "#f1c40f", "#f39c12", "#2ecc71", "#27ae60", "#e67e22", "#d35400", "#3498db", "#2980b9", "#e74c3c", "#c0392b", "#9b59b6", "#8e44ad", "#bdc3c7", "#34495e", "#2c3e50", "#95a5a6", "#7f8c8d", "#ec87bf", "#d870ad", "#f69785", "#9ba37e", "#b49255", "#b49255", "#a94136"];

	let getInitials = s => {
		let str = s.split(" ");

		return (str[0][0] + (str[1] ? str[1][0] : str[0][1])).toUpperCase();
	};

	let init = (id, set) => {
		let settings = {
			radius: set.radius || "15px",
			size: set.size || 100,
			fontSize: set.fontSize || "48px",
			color: set.color || colors[getRandom(0, colors.length)]
		};

		let img = document.getElementById(id);
		img.style.width = "100%";
		img.style.maxWidth = settings.size + "px";
		img.style.borderRadius = settings.radius;

		let text = document.createElementNS("http://www.w3.org/2000/svg", "text");
		text.setAttribute("text-anchor", "middle");
		text.setAttribute("y", "50%");
		text.setAttribute("x", "50%");
		text.setAttribute("dy", "0.35em");
		text.setAttribute("pointer-events", "auto");
		text.setAttribute("fill", "white");
		text.setAttribute(
			"style",
			`font-weight: bold; font-size: ${settings.fontSize}; font-family: Montserrat, sans-serif;`
		);
		text.textContent = getInitials(img.dataset.initials);

		let svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
		svg.setAttribute("xmlns", "http://www.w3.org/2000/svg");
		svg.setAttribute("pointer-events", "none");
		svg.setAttribute("width", settings.size);
		svg.setAttribute("height", settings.size);
		svg.setAttribute("style", `background-color: ${settings.color};`);
		svg.appendChild(text);

		let tempDiv = document.createElement("DIV");
		tempDiv.appendChild(svg.cloneNode(true));
		let svgHtml = window.btoa(decodeURI(encodeURI(tempDiv.innerHTML)));

		img.setAttribute("src", "data:image/svg+xml;base64," + svgHtml);
	};

	let getRandom = (min, max) => {
		return Math.floor(Math.random() * (max - min)) + min;
	};

	return {
		init
	};
})();

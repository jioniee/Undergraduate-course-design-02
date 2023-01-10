// Encapsulate the paging function plug-in pagess
//  (data volume, page start position, page length)
function pagess(tot, p, size) {
	// Calculate the start position of the page number
	let start = (p - 1) * size;
	// Calculate the total number of pages
	let pages = Math.ceil(tot / size);
	// Show paging effect
	let show = "";
	show +=`<a href="?p=1">first page</a>`;
	show +=`<a href="?p=${p-1 >=1 ? p-1: 1 }">previous</a>`;
	show +=`<span class="current">${p}</span>`;
	show +=`<a href="?p=${Number(p)+1 <= pages ? Number(p)+1: pages}">next</a>`;
	show +=`<a href="?p=${pages}">last page</a>`;
	return {
		tot,
		start,
		size,
		show
	}
}
module.exports = pagess;
const e=window.matchMedia("(prefers-color-scheme: dark)").matches,t=()=>{document.documentElement.classList.remove("dark")},s=()=>{document.documentElement.classList.add("dark")};let o="dark"===localStorage.getItem("theme")?2:"light"===localStorage.getItem("theme")?1:0;const a=document.getElementById("theme-toggle");a.addEventListener("click",(()=>{switch(o=(o+1)%3,o){case 0:localStorage.removeItem("theme"),e?document.documentElement.classList.add("dark"):document.documentElement.classList.remove("dark"),a.innerText="theme: system";break;case 1:e?(localStorage.setItem("theme","light"),t(),a.innerText="theme: light"):(localStorage.setItem("theme","dark"),s(),a.innerText="theme: dark");break;case 2:e?(localStorage.setItem("theme","dark"),s(),a.innerText="theme: dark"):(localStorage.setItem("theme","light"),t(),a.innerText="theme: light")}}));const n=()=>{document.body.classList.remove("font-sans"),document.body.classList.remove("font-serif")},m=e=>{e&&"serif"===e&&(n(),document.body.classList.add("font-serif")),e&&"sans"===e&&(n(),document.body.classList.add("font-sans")),e||n()};let c=localStorage.getItem("font");m();const l=document.getElementById("font-toggle");l.addEventListener("click",(()=>{c=localStorage.getItem("font"),"sans"===c?(c="serif",l.innerText="serif",localStorage.setItem("font","serif")):(c="sans",l.innerText="sans",localStorage.setItem("font","sans")),m(c)}));

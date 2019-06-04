const criarLink = (t) => `<a target="_blank" href="https://translate.google.com/m/translate?ie=UTF8&sl=pt-BR&tl=en&q=#en/pt/${t}">${t}</a>`;

function criarTextoClicavel(seletor) {  
  const div = document.querySelector(seletor);
  div.innerHTML = div.textContent
                     .split(' ')
                     .reduce(
                       (ant, atu) => `${ant} ${criarLink(atu)}`
                     ,'');
}

criarTextoClicavel('#texto-clicavel');

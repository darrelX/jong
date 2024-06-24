const crypto = require('crypto');

const salt = 'abcdfb'; // Valeur de sel utilisée dans le hachage

function generateSalt() {
    let bytes = new Uint8Array(2);
    crypto.getRandomValues(bytes);
    console.log(bytes);

    const b = Array.from(bytes).map(byte => byte.toString(16).padStart(2, '0')).join('');
    const intValue = parseInt(b, 16);
    console.log(intValue);
}

// Exemple d'utilisation
console.log(generateSalt());
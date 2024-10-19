function downloadFile({
    filename, 
    content,
    contentType
}) {
    const blob = new Blob([content], { type: contentType }); // Cambia il tipo se necessario
    const url = URL.createObjectURL(blob); // Crea un URL per il blob

    const a = document.createElement('a');
    a.href = url;
    a.download = filename; // Assegna il nome del file

    document.body.appendChild(a);
    a.click(); 
    document.body.removeChild(a);

    URL.revokeObjectURL(url);
}

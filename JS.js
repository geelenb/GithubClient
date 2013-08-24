function printPage (url) {
    var xhr = new XMLHttpRequest;
    console.log(url)
    xhr.open("GET", url);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            console.log(xhr.responseText);
        }
    }
    xhr.send();
}

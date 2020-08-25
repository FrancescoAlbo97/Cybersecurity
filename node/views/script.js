$(document).ready(function(){
    const fileInput = document.querySelector('#file-js-example input[type=file]');
    fileInput.onchange = () => {
    if (fileInput.files.length > 0) {
        const fileName = document.querySelector('#file-js-example .file-name');
        fileName.textContent = fileInput.files[0].name;

        let bt = document.getElementById('btSubmit');
        bt.removeAttribute("disabled")
    }
    else{
        bt.setAttribute("disabled")
    }
    }
});
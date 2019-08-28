'use strict'
// document.addEventListener('DOMContentLoaded', function () {
//     var elems = document.querySelectorAll('select')
//     var instances = M.FormSelect.init(elems, null)
// })
$(document).ready(function () {
    $('select').formSelect();
});
const prefecture_selectbox = document.querySelectorAll('select[name="prefecture"]')

$(function () {
    $.ajax({
        type: 'get',
        url: './getFoods.php',
        dataType: 'json',
    }).done(data => {
        createOptions(data);
    })
})
const createOptions = (data) => {
    console.log(data);
    for (let i = 0; i < prefecture_selectbox.length; i++) {
        data.forEach((key, idx) => {
            let option = document.createElement('option')
            option.value = key.id
            option.text = key.name
            if (!idx) option.selected = true
            prefecture_selectbox[i].appendChild(option)
        })
    }
    $('select').formSelect();
}
'use strict'
$(document).ready(function () {
    $('select').formSelect();
});
const prefecture_selectbox = document.querySelectorAll('select[name="prefecture"]')

$(function () {
    $.ajax({
        type: 'get',
        url: './getPrefecture.php',
        dataType: 'json',
    }).done(data => {
        createOptions(data);
    })
    $.ajax({
        type: 'get',
        url: './getFoods.php',
        dataType: 'json',
    }).done(data => {
        createFoodsOption(data);
    })
})
const createOptions = (data) => {
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
const createFoodsOption = (data) => {
    const foods_selectbox = document.querySelector('select[name="foods[]"]')
    data.forEach((key, idx) => {
        let option = document.createElement('option')
        option.value = key.id
        option.text = key.name
        foods_selectbox.appendChild(option)
    })
    const base_foods_selectbox = document.querySelector('select[name="base_food"]')
    data.forEach((key, idx) => {
        let option = document.createElement('option')
        option.value = key.id
        option.text = key.name
        base_foods_selectbox.appendChild(option)
    })
    $('select').formSelect();
}
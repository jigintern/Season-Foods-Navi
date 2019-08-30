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
        console.log('success');
        console.log(data);
        createOptions(data);
    }).fail(function (jqXHR, textStatus, errorThrown) {
        // エラーの場合処理
        console.log("エラーが発生しました。ステータス：" + jqXHR.status);
        console.log(textStatus);
        console.log(errorThrown);
    });
    $.ajax({
        type: 'get',
        url: './getFoods.php',
        dataType: 'json',
    }).done(data => {
        console.log('success');
        console.log(data)
        createFoodsOption(data);
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("エラーが発生しました。ステータス：" + jqXHR.status);
        console.log(textStatus);
        console.log(errorThrown);
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
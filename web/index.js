'use strict'
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select')
    var instances = M.FormSelect.init(elems, null)
});
const prefecture_selectbox = document.querySelectorAll('select[name="prefecture"]')
const prefecture_list = ['福岡', '福井', '北海道']
let prefecture_dom = ''
for(let i = 0; i < prefecture_selectbox.length; i++) {
    prefecture_list.forEach((key, idx) => {
        let option = document.createElement('option')
        option.value = idx
        option.text = key
        if(!idx) option.selected = true 
        prefecture_selectbox[i].appendChild(option)
    })
}
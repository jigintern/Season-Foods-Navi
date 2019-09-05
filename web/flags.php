<?php
class LL {
    private $is_login = false;
    function login() {
        $this->is_login = true;
    }
    function logout() {
        $this->is_login = false;
    }
    function IsLogin() {
        return $this->is_login;
    }
}
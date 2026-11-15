<?php
function rupiah($n){return 'Rp '.number_format((float)$n,0,',','.');}
function is_logged_in(){return !empty($_SESSION['user']);}
function is_admin(){return is_logged_in() && $_SESSION['user']['role']==='admin';}
function cart_count(){return array_sum(array_column($_SESSION['cart']??[],'qty'));}
function cart_total(){ $t=0; foreach($_SESSION['cart']??[] as $i){$t+=$i['price']*$i['qty'];} return $t; }
function final_price($p){return $p['price']*(1-($p['discount_percent']??0)/100);}
function require_login(){if(!is_logged_in()){header('Location: login.php');exit;}}
function require_admin(){if(!is_admin()){header('Location: ../login.php');exit;}}
?>

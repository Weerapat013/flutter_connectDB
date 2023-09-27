<?php 
    include('connectDB.php');

	$fullname = $_POST['fullname'];
	$username = $_POST['username'];
	$password = $_POST['password'];

	$sql = "UPDATE users SET fullname = '".$fullname."',password = '".$password."' WHERE username = '".$username."'";

	//$con->query("UPDATE users SET fullname = '".$fullname."',password = '".$password."' WHERE username = '".$username."'");

	if($con->query($sql)){
		echo json_encode('Success');
	} else {
		echo json_encode('Error');
	}
?>
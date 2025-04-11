<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Patient Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="vendor/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .login-container {
            width: 40%;
            margin: 100px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        .login-title {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">HospDBMS | Patient Login</h2>
        <form method="post" action="UserDashboardServlet">
            <div class="form-group">
                <label>User Name</label>
                <input type="text" name="uname" class="form-control" placeholder="Username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="pwd" class="form-control" placeholder="Password" required>
            </div>
            <div class="form-group">
                <p>Don't have an account? <a href="newuser.html">Create account</a></p>
            </div>
            <button type="submit" class="btn btn-primary">Login <i class="fa fa-arrow-circle-right"></i></button>
        </form>
    </div>
    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has("error")) {
                alert(urlParams.get("error"));
            }
            if (urlParams.has("message")) {
                alert(urlParams.get("message"));
            }
        };
    </script>
</body>
</html>

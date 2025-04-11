<html lang="en">
<head>
    <title>Admin Login</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="" name="description" />
    <meta content="" name="author" />
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .main-login {
            width: 40%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        .box-login {
            padding: 20px;
        }
        .form-login input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="row">
        <div class="main-login">
            <div class="logo margin-top-30">
                <b><h1>HospDBMS | Admin Login</h1></b>
            </div>
            <div class="box-login">
                <form class="form-login" method="post" action="AdminDashboardServlet">
                    <fieldset>
                        <legend>Sign in to your account</legend>
                        <p>Please enter your name and password to log in.<br /></p>
                        <font color="red"><p>${error}</p></font>
                        <div class="form-group">
                            <span class="input-icon">
                                <input type="text" class="form-control" name="username" placeholder="Username">
                            </span>
                        </div>
                        <div class="form-group form-actions">
                            <span class="input-icon">
                                <input type="password" class="form-control password" name="password" placeholder="Password">
                            </span>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-primary" name="submit">
                                Login <i class="fa fa-arrow-circle-right"></i>
                            </button>
                        </div>
                    </fieldset>
                </form>
                <div class="copyright">
                    &copy; <span class="current-year"></span><span class="text-bold text-uppercase"> HospDBMS</span>. <span>All rights reserved</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

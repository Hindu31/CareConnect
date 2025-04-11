<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>patient login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" media="screen" href="main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.3/semantic.min.css">
    <link rel="stylesheet" href="plog.css">
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="vendor/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="vendor/themify-icons/themify-icons.min.css">
    <link href="vendor/animate.css/animate.min.css" rel="stylesheet" media="screen">
    <link href="vendor/perfect-scrollbar/perfect-scrollbar.min.css" rel="stylesheet" media="screen">
    <link href="vendor/switchery/switchery.min.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/plugins.css">
    <link rel="stylesheet" href="assets/css/themes/theme-1.css" id="skin_color" />
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .dashboard-container {
            width: 80%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        .dashboard-title {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .dashboard-cards {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }
        .dashboard-card {
            flex: 1;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2);
        }
        label {
            font-size: 18px;
            font-weight: bold;
            color: #5B86E5;
        }
        button {
            background: linear-gradient(to right, #FF512F, #DD2476);
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            border-radius: 5px;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        button:hover {
            transform: scale(1.05);
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
  <!--patient login page--><br><br><br>
  <center><div class="logo margin-top-30">
      <h2> HospDBMS | Doc Login</h2><br>
  </div></center>
  <div class="ui container login">
      <div class="ui red centered card">
          <form class="ui form log" method="post" action="DoctorDashboardServlet">
              <div class="field">
                  <div class="sixteen wide field">
                      <br>
                      <label class="header">User Name</label>
                      <input type="text" name="uname" placeholder="username">
                  </div>
              </div>
              <div class="field">
                  <div class="sixteen wide field">
                      <label class="ui header">Password</label>
                      <input type="password" name="pwd" placeholder="password">
                  </div>
              </div>
              <button type="submit" class="btn btn-primary pull-right" name="submit">
                  Login <i class="fa fa-arrow-circle-right"></i>
              </button>
          </form>
      </div>
  </div>
</body>
</html>

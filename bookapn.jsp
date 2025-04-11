<!DOCTYPE html>
<html lang="en">
<head>
    <title>User | Book Appointment</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="vendor/fontawesome/css/font-awesome.min.css">
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .form-group {
            text-align: left;
        }
        .btn-primary {
            background-color: #5B86E5;
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User | Book Appointment</h1>
        <form method="post" action="successbapn.jsp?pname=<%=request.getParameter("pname")%>">
            <div class="form-group">
                <label for="DoctorSpecialization">Doctor Specialization</label>
                <select name="dspec" class="form-control" required>
                    <option value="">Select Specialization</option>
                    <option value="Brain surgery">Brain surgery</option>
                    <option value="Heart surgery">Heart surgery</option>
                    <option value="Plastic surgery">Plastic surgery</option>
                    <option value="Cancer treatment">Cancer treatment</option>
                    <option value="Basic treatment">Basic treatment</option>
                </select>
            </div>
            <div class="form-group">
                <label for="doctor">Doctors</label>
                <select name="dname" class="form-control" required>
                    <option value="">Select Doctor</option>
                    <option value="Doc1">Doc1</option>
                    <option value="Doc2">Doc2</option>
                    <option value="Doc3">Doc3</option>
                </select>
            </div>
            <div class="form-group">
                <label for="AppointmentDate">Date</label>
                <input class="form-control" name="date" required placeholder="YYYY-MM-DD">
            </div>
            <div class="form-group">
                <label for="Appointmenttime">Time</label>
                <input class="form-control" name="time" required placeholder="HH:MM:SS">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</body>
</html>

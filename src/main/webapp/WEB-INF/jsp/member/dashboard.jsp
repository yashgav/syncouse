<%-- 
    Document   : dashboard
    Created on : Feb 21, 2023, 4:46:19 PM
    Author     : Yash
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = (String) request.getAttribute("user");
    String scode = (String) request.getAttribute("scode");

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
    PreparedStatement stmt1 = con.prepareStatement("SELECT * FROM Userdetails where scode=? and username=?");
    stmt1.setString(1, scode);
    stmt1.setString(2, user);
    ResultSet rs = stmt1.executeQuery();
    String fn = null, sn = null, fl = null;
    while (rs.next()) {
        fn = rs.getString("FNAME");
        sn = rs.getString("SNAME");
        fl = rs.getString("FLATNO");
    }

    PreparedStatement stmt2 = con.prepareStatement("SELECT * FROM announcement where scode=? ");
    stmt2.setString(1, scode);

    ResultSet rs2 = stmt2.executeQuery();

    String mess = null, subs = null;
    while (rs2.next()) {
        mess = rs2.getString("MESSAGE");
        subs = rs2.getString("SUBJECT");
    }
    System.out.println("mess: " + mess);
    System.out.println("subs: " + subs);
    
    PreparedStatement stmt3 = con.prepareStatement("SELECT count(*) as ta FROM userdetails where scode=? and role=?");
    stmt3.setString(1, scode);
    stmt3.setString(2, "Admin");

    ResultSet rs3 = stmt3.executeQuery();

    int ta = 0; int tm = 0;
    while (rs3.next()) {
        ta = rs3.getInt("ta");
    }
    
    PreparedStatement stmt4 = con.prepareStatement("SELECT count(*) as tm FROM userdetails where scode=? and role=?");
    stmt4.setString(1, scode);
    stmt4.setString(2, "Member");

    ResultSet rs4 = stmt4.executeQuery();

    while (rs4.next()) {
        tm = rs4.getInt("tm");
    }
    
    PreparedStatement stmt5 = con.prepareStatement("SELECT * FROM USERDETAILS WHERE SCODE=? AND ROLE=? ORDER BY ID DESC LIMIT 5;");
    stmt5.setString(1, scode);
    stmt5.setString(2, "Member");

    ResultSet rs5 = stmt5.executeQuery();
    String usernames[]=new String[100];
    String flatnos[]=new String[100];
    String gen[]=new String[100];
    int o=0;
    while (rs5.next()) {
        usernames[o] = rs5.getString("USername");
        flatnos[o] = rs5.getString("flatno");
        gen[o] = rs5.getString("gender");
        o++;
    }
    
    


%> 
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Syncouse | Member Dashboard</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
            rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.7.0.min.js"
        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    </head>


    <style>
        :root {
            scroll-behavior: smooth;
        }

        body {
            font-family: "Open Sans", sans-serif;
            background: #f6f9ff;
            color: #444444;
        }

        a {
            color: #4154f1;
            text-decoration: none;
        }

        a:hover {
            color: #717ff5;
            text-decoration: none;
        }

        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            font-family: "Nunito", sans-serif;
        }

        /*--------------------------------------------------------------
        # Main
        --------------------------------------------------------------*/
        #main {
            margin-top: 60px;
            padding: 20px 30px;
            transition: all 0.3s;
        }

        @media (max-width: 1199px) {
            #main {
                padding: 20px;
            }
        }

        /*--------------------------------------------------------------
        # Page Title
        --------------------------------------------------------------*/
        .pagetitle {
            margin-bottom: 10px;
        }

        .pagetitle h1 {
            font-size: 24px;
            margin-bottom: 0;
            font-weight: 600;
            color: #012970;
        }

        /*--------------------------------------------------------------
        # Back to top button
        --------------------------------------------------------------*/
        .back-to-top {
            position: fixed;
            visibility: hidden;
            opacity: 0;
            right: 15px;
            bottom: 15px;
            z-index: 99999;
            background: #4154f1;
            width: 40px;
            height: 40px;
            border-radius: 4px;
            transition: all 0.4s;
        }

        .back-to-top i {
            font-size: 24px;
            color: #fff;
            line-height: 0;
        }

        .back-to-top:hover {
            background: #6776f4;
            color: #fff;
        }

        .back-to-top.active {
            visibility: visible;
            opacity: 1;
        }

        /*--------------------------------------------------------------
        # Override some default Bootstrap stylings
        --------------------------------------------------------------*/
        /* Dropdown menus */
        .dropdown-menu {
            border-radius: 4px;
            padding: 10px 0;
            animation-name: dropdown-animate;
            animation-duration: 0.2s;
            animation-fill-mode: both;
            border: 0;
            box-shadow: 0 5px 30px 0 rgba(82, 63, 105, 0.2);
        }

        .dropdown-menu .dropdown-header,
        .dropdown-menu .dropdown-footer {
            text-align: center;
            font-size: 15px;
            padding: 10px 25px;
        }

        .dropdown-menu .dropdown-footer a {
            color: #444444;
            text-decoration: underline;
        }

        .dropdown-menu .dropdown-footer a:hover {
            text-decoration: none;
        }

        .dropdown-menu .dropdown-divider {
            color: #a5c5fe;
            margin: 0;
        }

        .dropdown-menu .dropdown-item {
            font-size: 14px;
            padding: 10px 15px;
            transition: 0.3s;
        }

        .dropdown-menu .dropdown-item i {
            margin-right: 10px;
            font-size: 18px;
            line-height: 0;
        }

        .dropdown-menu .dropdown-item:hover {
            background-color: #f6f9ff;
        }

        @media (min-width: 768px) {
            .dropdown-menu-arrow::before {
                content: "";
                width: 13px;
                height: 13px;
                background: #fff;
                position: absolute;
                top: -7px;
                right: 20px;
                transform: rotate(45deg);
                border-top: 1px solid #eaedf1;
                border-left: 1px solid #eaedf1;
            }
        }

        @keyframes dropdown-animate {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }

            0% {
                opacity: 0;
            }
        }

        /* Light Backgrounds */
        .bg-primary-light {
            background-color: #cfe2ff;
            border-color: #cfe2ff;
        }

        .bg-secondary-light {
            background-color: #e2e3e5;
            border-color: #e2e3e5;
        }

        .bg-success-light {
            background-color: #d1e7dd;
            border-color: #d1e7dd;
        }

        .bg-danger-light {
            background-color: #f8d7da;
            border-color: #f8d7da;
        }

        .bg-warning-light {
            background-color: #fff3cd;
            border-color: #fff3cd;
        }

        .bg-info-light {
            background-color: #cff4fc;
            border-color: #cff4fc;
        }

        .bg-dark-light {
            background-color: #d3d3d4;
            border-color: #d3d3d4;
        }

        /* Card */
        .card {
            margin-bottom: 30px;
            border: none;
            border-radius: 5px;
            box-shadow: 0px 0 30px rgba(1, 41, 112, 0.1);
        }

        .card-header,
        .card-footer {
            border-color: #ebeef4;
            background-color: #fff;
            color: #798eb3;
            padding: 15px;
        }

        .card-title {
            padding: 20px 0 15px 0;
            font-size: 18px;
            font-weight: 500;
            color: #012970;
            font-family: "Poppins", sans-serif;
        }

        .card-title span {
            color: #899bbd;
            font-size: 14px;
            font-weight: 400;
        }

        .card-body {
            padding: 0 20px 20px 20px;
        }

        .card-img-overlay {
            background-color: rgba(255, 255, 255, 0.6);
        }

        /* Alerts */
        .alert-heading {
            font-weight: 500;
            font-family: "Poppins", sans-serif;
            font-size: 20px;
        }

        /* Close Button */
        .btn-close {
            background-size: 25%;
        }

        .btn-close:focus {
            outline: 0;
            box-shadow: none;
        }

        /* Accordion */
        .accordion-item {
            border: 1px solid #ebeef4;
        }

        .accordion-button:focus {
            outline: 0;
            box-shadow: none;
        }

        .accordion-button:not(.collapsed) {
            color: #012970;
            background-color: #f6f9ff;
        }

        .accordion-flush .accordion-button {
            padding: 15px 0;
            background: none;
            border: 0;
        }

        .accordion-flush .accordion-button:not(.collapsed) {
            box-shadow: none;
            color: #4154f1;
        }

        .accordion-flush .accordion-body {
            padding: 0 0 15px 0;
            color: #3e4f6f;
            font-size: 15px;
        }

        /* Breadcrumbs */
        .breadcrumb {
            font-size: 14px;
            font-family: "Nunito", sans-serif;
            color: #899bbd;
            font-weight: 600;
        }

        .breadcrumb a {
            color: #899bbd;
            transition: 0.3s;
        }

        .breadcrumb a:hover {
            color: #51678f;
        }

        .breadcrumb .breadcrumb-item::before {
            color: #899bbd;
        }

        .breadcrumb .active {
            color: #51678f;
            font-weight: 600;
        }

        /* Bordered Tabs */
        .nav-tabs-bordered {
            border-bottom: 2px solid #ebeef4;
        }

        .nav-tabs-bordered .nav-link {
            margin-bottom: -2px;
            border: none;
            color: #2c384e;
        }

        .nav-tabs-bordered .nav-link:hover,
        .nav-tabs-bordered .nav-link:focus {
            color: #4154f1;
        }

        .nav-tabs-bordered .nav-link.active {
            background-color: #fff;
            color: #4154f1;
            border-bottom: 2px solid #4154f1;
        }

        /*--------------------------------------------------------------
        # Header
        --------------------------------------------------------------*/
        .logo {
            line-height: 1;
        }

        @media (min-width: 1200px) {
            .logo {
                width: 280px;
            }
        }

        .logo img {
            max-height: 26px;
            margin-right: 6px;
        }

        .logo span {
            font-size: 26px;
            font-weight: 700;
            color: #012970;
            font-family: "Nunito", sans-serif;
        }

        .header {
            transition: all 0.5s;
            z-index: 997;
            height: 60px;
            box-shadow: 0px 2px 20px rgba(1, 41, 112, 0.1);
            background-color: #fff;
            padding-left: 20px;
            /* Toggle Sidebar Button */
            /* Search Bar */
        }

        .header .toggle-sidebar-btn {
            font-size: 32px;
            padding-left: 10px;
            cursor: pointer;
            color: #012970;
        }

        .header .search-bar {
            min-width: 360px;
            padding: 0 20px;
        }

        @media (max-width: 1199px) {
            .header .search-bar {
                position: fixed;
                top: 50px;
                left: 0;
                right: 0;
                padding: 20px;
                box-shadow: 0px 0px 15px 0px rgba(1, 41, 112, 0.1);
                background: white;
                z-index: 9999;
                transition: 0.3s;
                visibility: hidden;
                opacity: 0;
            }

            .header .search-bar-show {
                top: 60px;
                visibility: visible;
                opacity: 1;
            }
        }

        .header .search-form {
            width: 100%;
        }

        .header .search-form input {
            border: 0;
            font-size: 14px;
            color: #012970;
            border: 1px solid rgba(1, 41, 112, 0.2);
            padding: 7px 38px 7px 8px;
            border-radius: 3px;
            transition: 0.3s;
            width: 100%;
        }

        .header .search-form input:focus,
        .header .search-form input:hover {
            outline: none;
            box-shadow: 0 0 10px 0 rgba(1, 41, 112, 0.15);
            border: 1px solid rgba(1, 41, 112, 0.3);
        }

        .header .search-form button {
            border: 0;
            padding: 0;
            margin-left: -30px;
            background: none;
        }

        .header .search-form button i {
            color: #012970;
        }

        /*--------------------------------------------------------------
        # Header Nav
        --------------------------------------------------------------*/
        .header-nav ul {
            list-style: none;
        }

        .header-nav>ul {
            margin: 0;
            padding: 0;
        }

        .header-nav .nav-icon {
            font-size: 22px;
            color: #012970;
            margin-right: 25px;
            position: relative;
        }

        .header-nav .nav-profile {
            color: #012970;
        }

        .header-nav .nav-profile img {
            max-height: 36px;
        }

        .header-nav .nav-profile span {
            font-size: 14px;
            font-weight: 600;
        }

        .header-nav .badge-number {
            position: absolute;
            inset: -2px -5px auto auto;
            font-weight: normal;
            font-size: 12px;
            padding: 3px 6px;
        }

        .header-nav .notifications {
            inset: 8px -15px auto auto !important;
        }

        .header-nav .notifications .notification-item {
            display: flex;
            align-items: center;
            padding: 15px 10px;
            transition: 0.3s;
        }

        .header-nav .notifications .notification-item i {
            margin: 0 20px 0 10px;
            font-size: 24px;
        }

        .header-nav .notifications .notification-item h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .header-nav .notifications .notification-item p {
            font-size: 13px;
            margin-bottom: 3px;
            color: #919191;
        }

        .header-nav .notifications .notification-item:hover {
            background-color: #f6f9ff;
        }

        .header-nav .messages {
            inset: 8px -15px auto auto !important;
        }

        .header-nav .messages .message-item {
            padding: 15px 10px;
            transition: 0.3s;
        }

        .header-nav .messages .message-item a {
            display: flex;
        }

        .header-nav .messages .message-item img {
            margin: 0 20px 0 10px;
            max-height: 40px;
        }

        .header-nav .messages .message-item h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #444444;
        }

        .header-nav .messages .message-item p {
            font-size: 13px;
            margin-bottom: 3px;
            color: #919191;
        }

        .header-nav .messages .message-item:hover {
            background-color: #f6f9ff;
        }

        .header-nav .profile {
            min-width: 240px;
            padding-bottom: 0;
            top: 8px !important;
        }

        .header-nav .profile .dropdown-header h6 {
            font-size: 18px;
            margin-bottom: 0;
            font-weight: 600;
            color: #444444;
        }

        .header-nav .profile .dropdown-header span {
            font-size: 14px;
        }

        .header-nav .profile .dropdown-item {
            font-size: 14px;
            padding: 10px 15px;
            transition: 0.3s;
        }

        .header-nav .profile .dropdown-item i {
            margin-right: 10px;
            font-size: 18px;
            line-height: 0;
        }

        .header-nav .profile .dropdown-item:hover {
            background-color: #f6f9ff;
        }

        /*--------------------------------------------------------------
        # Sidebar
        --------------------------------------------------------------*/
        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            bottom: 0;
            width: 300px;
            z-index: 996;
            transition: all 0.3s;
            padding: 20px;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: #aab7cf transparent;
            box-shadow: 0px 0px 20px rgba(1, 41, 112, 0.1);
            background-color: #fff;
        }

        @media (max-width: 1199px) {
            .sidebar {
                left: -300px;
            }
        }

        .sidebar::-webkit-scrollbar {
            width: 5px;
            height: 8px;
            background-color: #fff;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background-color: #aab7cf;
        }

        @media (min-width: 1200px) {

            #main,
            #footer {
                margin-left: 300px;
            }
        }

        @media (max-width: 1199px) {
            .toggle-sidebar .sidebar {
                left: 0;
            }
        }

        @media (min-width: 1200px) {

            .toggle-sidebar #main,
            .toggle-sidebar #footer {
                margin-left: 0;
            }

            .toggle-sidebar .sidebar {
                left: -300px;
            }
        }

        .sidebar-nav {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        .sidebar-nav li {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        .sidebar-nav .nav-item {
            margin-bottom: 5px;
        }

        .sidebar-nav .nav-heading {
            font-size: 11px;
            text-transform: uppercase;
            color: #899bbd;
            font-weight: 600;
            margin: 10px 0 5px 15px;
        }

        .sidebar-nav .nav-link {
            display: flex;
            align-items: center;
            font-size: 15px;
            font-weight: 600;
            color: #4154f1;
            transition: 0.3;
            background: #f6f9ff;
            padding: 10px 15px;
            border-radius: 4px;
        }

        .sidebar-nav .nav-link i {
            font-size: 16px;
            margin-right: 10px;
            color: #4154f1;
        }

        .sidebar-nav .nav-link.collapsed {
            color: #012970;
            background: #fff;
        }

        .sidebar-nav .nav-link.collapsed i {
            color: #899bbd;
        }

        .sidebar-nav .nav-link:hover {
            color: #4154f1;
            background: #f6f9ff;
        }

        .sidebar-nav .nav-link:hover i {
            color: #4154f1;
        }

        .sidebar-nav .nav-link .bi-chevron-down {
            margin-right: 0;
            transition: transform 0.2s ease-in-out;
        }

        .sidebar-nav .nav-link:not(.collapsed) .bi-chevron-down {
            transform: rotate(180deg);
        }

        .sidebar-nav .nav-content {
            padding: 5px 0 0 0;
            margin: 0;
            list-style: none;
        }

        .sidebar-nav .nav-content a {
            display: flex;
            align-items: center;
            font-size: 14px;
            font-weight: 600;
            color: #012970;
            transition: 0.3;
            padding: 10px 0 10px 40px;
            transition: 0.3s;
        }

        .sidebar-nav .nav-content a i {
            font-size: 6px;
            margin-right: 8px;
            line-height: 0;
            border-radius: 50%;
        }

        .sidebar-nav .nav-content a:hover,
        .sidebar-nav .nav-content a.active {
            color: #4154f1;
        }

        .sidebar-nav .nav-content a.active i {
            background-color: #4154f1;
        }

        /*--------------------------------------------------------------
        # Dashboard
        --------------------------------------------------------------*/
        /* Filter dropdown */
        .dashboard .filter {
            position: absolute;
            right: 0px;
            top: 15px;
        }

        .dashboard .filter .icon {
            color: #aab7cf;
            padding-right: 20px;
            padding-bottom: 5px;
            transition: 0.3s;
            font-size: 16px;
        }

        .dashboard .filter .icon:hover,
        .dashboard .filter .icon:focus {
            color: #4154f1;
        }

        .dashboard .filter .dropdown-header {
            padding: 8px 15px;
        }

        .dashboard .filter .dropdown-header h6 {
            text-transform: uppercase;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 1px;
            color: #aab7cf;
            margin-bottom: 0;
            padding: 0;
        }

        .dashboard .filter .dropdown-item {
            padding: 8px 15px;
        }

        /* Info Cards */
        .dashboard .info-card {
            padding-bottom: 10px;
        }

        .dashboard .info-card h6 {
            font-size: 28px;
            color: #012970;
            font-weight: 700;
            margin: 0;
            padding: 0;
        }

        .dashboard .card-icon {
            font-size: 32px;
            line-height: 0;
            width: 64px;
            height: 64px;
            flex-shrink: 0;
            flex-grow: 0;
        }

        .dashboard .sales-card .card-icon {
            color: #4154f1;
            background: #f6f6fe;
        }

        .dashboard .revenue-card .card-icon {
            color: #2eca6a;
            background: #e0f8e9;
        }

        .dashboard .customers-card .card-icon {
            color: #ff771d;
            background: #ffecdf;
        }

        /* Activity */
        .dashboard .activity {
            font-size: 14px;
        }

        .dashboard .activity .activity-item .activite-label {
            color: #888;
            position: relative;
            flex-shrink: 0;
            flex-grow: 0;
            min-width: 64px;
        }

        .dashboard .activity .activity-item .activite-label::before {
            content: "";
            position: absolute;
            right: -11px;
            width: 4px;
            top: 0;
            bottom: 0;
            background-color: #eceefe;
        }

        .dashboard .activity .activity-item .activity-badge {
            margin-top: 3px;
            z-index: 1;
            font-size: 11px;
            line-height: 0;
            border-radius: 50%;
            flex-shrink: 0;
            border: 3px solid #fff;
            flex-grow: 0;
        }

        .dashboard .activity .activity-item .activity-content {
            padding-left: 10px;
            padding-bottom: 20px;
        }

        .dashboard .activity .activity-item:first-child .activite-label::before {
            top: 5px;
        }

        .dashboard .activity .activity-item:last-child .activity-content {
            padding-bottom: 0;
        }

        /* News & Updates */
        .dashboard .news .post-item+.post-item {
            margin-top: 15px;
        }

        .dashboard .news img {
            width: 80px;
            float: left;
            border-radius: 5px;
        }

        .dashboard .news h4 {
            font-size: 15px;
            margin-left: 95px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .dashboard .news h4 a {
            color: #012970;
            transition: 0.3s;
        }

        .dashboard .news h4 a:hover {
            color: #4154f1;
        }

        .dashboard .news p {
            font-size: 14px;
            color: #777777;
            margin-left: 95px;
        }

        /* Recent Sales */
        .dashboard .recent-sales {
            font-size: 14px;
        }

        .dashboard .recent-sales .table thead {
            background: #f6f6fe;
        }

        .dashboard .recent-sales .table thead th {
            border: 0;
        }

        .dashboard .recent-sales .dataTable-top {
            padding: 0 0 10px 0;
        }

        .dashboard .recent-sales .dataTable-bottom {
            padding: 10px 0 0 0;
        }

        /* Top Selling */
        .dashboard .top-selling {
            font-size: 14px;
        }

        .dashboard .top-selling .table thead {
            background: #f6f6fe;
        }

        .dashboard .top-selling .table thead th {
            border: 0;
        }

        .dashboard .top-selling .table tbody td {
            vertical-align: middle;
        }

        .dashboard .top-selling img {
            border-radius: 5px;
            max-width: 60px;
        }

        /*--------------------------------------------------------------
        # Icons list page
        --------------------------------------------------------------*/
        .iconslist {
            display: grid;
            max-width: 100%;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1.25rem;
            padding-top: 15px;
        }

        .iconslist .icon {
            background-color: #fff;
            border-radius: 0.25rem;
            text-align: center;
            color: #012970;
            padding: 15px 0;
        }

        .iconslist i {
            margin: 0.25rem;
            font-size: 2.5rem;
        }

        .iconslist .label {
            font-family: var(--bs-font-monospace);
            display: inline-block;
            width: 100%;
            overflow: hidden;
            padding: 0.25rem;
            font-size: 12px;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #666;
        }

        /*--------------------------------------------------------------
        # Profie Page
        --------------------------------------------------------------*/
        .profile .profile-card img {
            max-width: 120px;
        }

        .profile .profile-card h2 {
            font-size: 24px;
            font-weight: 700;
            color: #2c384e;
            margin: 10px 0 0 0;
        }

        .profile .profile-card h3 {
            font-size: 18px;
        }

        .profile .profile-card .social-links a {
            font-size: 20px;
            display: inline-block;
            color: rgba(1, 41, 112, 0.5);
            line-height: 0;
            margin-right: 10px;
            transition: 0.3s;
        }

        .profile .profile-card .social-links a:hover {
            color: #012970;
        }

        .profile .profile-overview .row {
            margin-bottom: 20px;
            font-size: 15px;
        }

        .profile .profile-overview .card-title {
            color: #012970;
        }

        .profile .profile-overview .label {
            font-weight: 600;
            color: rgba(1, 41, 112, 0.6);
        }

        .profile .profile-edit label {
            font-weight: 600;
            color: rgba(1, 41, 112, 0.6);
        }

        .profile .profile-edit img {
            max-width: 120px;
        }

        /*--------------------------------------------------------------
        # F.A.Q Page
        --------------------------------------------------------------*/
        .faq .basic h6 {
            font-size: 18px;
            font-weight: 600;
            color: #4154f1;
        }

        .faq .basic p {
            color: #6980aa;
        }

        /*--------------------------------------------------------------
        # Contact
        --------------------------------------------------------------*/
        .contact .info-box {
            padding: 28px 30px;
        }

        .contact .info-box i {
            font-size: 38px;
            line-height: 0;
            color: #4154f1;
        }

        .contact .info-box h3 {
            font-size: 20px;
            color: #012970;
            font-weight: 700;
            margin: 20px 0 10px 0;
        }

        .contact .info-box p {
            padding: 0;
            line-height: 24px;
            font-size: 14px;
            margin-bottom: 0;
        }

        .contact .php-email-form .error-message {
            display: none;
            color: #fff;
            background: #ed3c0d;
            text-align: left;
            padding: 15px;
            margin-bottom: 24px;
            font-weight: 600;
        }

        .contact .php-email-form .sent-message {
            display: none;
            color: #fff;
            background: #18d26e;
            text-align: center;
            padding: 15px;
            margin-bottom: 24px;
            font-weight: 600;
        }

        .contact .php-email-form .loading {
            display: none;
            background: #fff;
            text-align: center;
            padding: 15px;
            margin-bottom: 24px;
        }

        .contact .php-email-form .loading:before {
            content: "";
            display: inline-block;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            margin: 0 10px -6px 0;
            border: 3px solid #18d26e;
            border-top-color: #eee;
            animation: animate-loading 1s linear infinite;
        }

        .contact .php-email-form input,
        .contact .php-email-form textarea {
            border-radius: 0;
            box-shadow: none;
            font-size: 14px;
            border-radius: 0;
        }

        .contact .php-email-form input:focus,
        .contact .php-email-form textarea:focus {
            border-color: #4154f1;
        }

        .contact .php-email-form input {
            padding: 10px 15px;
        }

        .contact .php-email-form textarea {
            padding: 12px 15px;
        }

        .contact .php-email-form button[type=submit] {
            background: #4154f1;
            border: 0;
            padding: 10px 30px;
            color: #fff;
            transition: 0.4s;
            border-radius: 4px;
        }

        .contact .php-email-form button[type=submit]:hover {
            background: #5969f3;
        }

        @keyframes animate-loading {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        /*--------------------------------------------------------------
        # Error 404
        --------------------------------------------------------------*/
        .error-404 {
            padding: 30px;
        }

        .error-404 h1 {
            font-size: 180px;
            font-weight: 700;
            color: #4154f1;
            margin-bottom: 0;
            line-height: 150px;
        }

        .error-404 h2 {
            font-size: 24px;
            font-weight: 700;
            color: #012970;
            margin-bottom: 30px;
        }

        .error-404 .btn {
            background: #51678f;
            color: #fff;
            padding: 8px 30px;
        }

        .error-404 .btn:hover {
            background: #3e4f6f;
        }

        @media (min-width: 992px) {
            .error-404 img {
                max-width: 50%;
            }
        }

        /*--------------------------------------------------------------
        # Footer
        --------------------------------------------------------------*/
        .footer {
            padding: 20px 0;
            font-size: 14px;
            transition: all 0.3s;
            border-top: 1px solid #cddfff;
        }

        .footer .copyright {
            text-align: center;
            color: #012970;
        }

        .footer .credits {
            padding-top: 5px;
            text-align: center;
            font-size: 13px;
            color: #012970;
        }
    </style>
    <style>
        .sidebut {
            background: none;
            border: none;
            padding: 0;
            margin: 0px;
        }

        .pbtns {
            background: none;
            border: none;
            padding: 0;
            margin: 0px;
            padding: 10px;
        }
        .fw{
            font-weight: 700;
        }
    </style>

    <body>

        <!-- ======= Header ======= -->
        <header id="header" class="header fixed-top d-flex align-items-center">

            <div class="d-flex align-items-center justify-content-between">
                <i class="bi bi-list toggle-sidebar-btn"></i>
                <span class=" d-none d-lg-block">Syncouse</span>
            </div><!-- End Logo -->


            <nav class="header-nav ms-auto">
                <ul class="d-flex align-items-center">

                    <li class="nav-item dropdown pe-3">

                        <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-person"></i>
                            <span class="d-none d-md-block dropdown-toggle ps-2"><%=user%></span>
                        </a><!-- End Profile Iamge Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                            <li class="dropdown-header">
                                <h6>${un}</h6>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <form action="member_personal_profile" class="nav-link collapsed">
                                    <button name="user" value="${un}" type="submit" class="pbtns">
                                        <i class="bi bi-person"></i>
                                        <span>My Profile</span>
                                    </button>
                                </form>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <form action="signout" class="nav-link collapsed">
                                    <button type="submit" class="pbtns">
                                        <i class="bi bi-box-arrow-right"></i>
                                        <span>Sign Out</span>
                                    </button>
                                </form>
                            </li>
                            

                        </ul><!-- End Profile Dropdown Items -->
                    </li><!-- End Profile Nav -->

                </ul>
            </nav><!-- End Icons Navigation -->

        </header><!-- End Header -->

        <!-- ======= Sidebar ======= -->
        <aside id="sidebar" class="sidebar">

            <ul class="sidebar-nav" id="sidebar-nav">

                <li class="nav-item">
                    <form action="admin_home" class="nav-link ">
                        <button type="submit" class="sidebut">
                            <i class="bi bi-speedometer2"></i>
                            <span>Dashboard</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="member_members" class="nav-link collapsed">
                        <button type="submit" class="sidebut">
                            <i class="bi bi-person-vcard"></i>
                            <span>Members</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="member_payments" class="nav-link collapsed">
                        <button type="submit" class="sidebut">
                            <i class="bi bi-currency-dollar"></i>
                            <span>Payments</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="member_announcement" class="nav-link collapsed">
                        <button type="submit" class="sidebut">
                            <i class="bi bi-megaphone"></i>
                            <span>Announcements</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="member_complaints" class="nav-link collapsed">
                        <button type="submit" class="sidebut">
                            <i class="bi bi-file-earmark-text"></i>
                            <span>Complaints</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->


                <li class="nav-heading">Pages</li>

                <li class="nav-item">
                    <form action="member_personal_profile" class="nav-link collapsed">
                        <button name="user" value="${un}" type="submit" class="sidebut">
                            <i class="bi bi-person"></i>
                            <span>My Profile</span>
                        </button>
                    </form>
                </li><!-- End Profile Page Nav -->
<!--
                <li class="nav-item">
                    <a class="nav-link collapsed" href="pages-contact.html">
                        <i class="bi bi-envelope"></i>
                        <span>Contact</span>
                    </a>
                </li> End Contact Page Nav -->

                <li class="nav-item">
                    <form action="signout" class="nav-link collapsed">
                        <button type="submit" class="sidebut">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>Sign Out</span>
                        </button>
                    </form>
                </li><!-- End Logout Page Nav -->

            </ul>

        </aside><!-- End Sidebar-->

        <main id="main" class="main">

            <div class="pagetitle">
                <h1>Dashboard</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html">Admin</a></li>
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->


            <section class="section dashboard">
                <div class="row">

                    <!-- Left side columns -->
                    <div class="col-lg-8">
                        <div class="row">
                            <style>
                                .gbg{
                                    color: grey;
                                    font-weight: 700;
                                    background: rgba(0,0,0,0.1);
                                    border-radius: 5px;
                                    padding: 0 5px;
                                }
                            </style>
                            <section>
                                <div class="jumbotron jumbotron-fluid">
                                    <div class="container">
                                        <h1 class="display-7 "><%=sn%></h1>
                                        <p class="lead">Society Code <span class="gbg"><%=scode%></span> </p>
                                    </div>
                                </div>
                            </section>

                            <!-- Sales Card -->
                            <div class="col-xxl-4 col-md-6">

                                <div class="card info-card sales-card">

                                    <div class="card-body">
                                        <h5 class="card-title">Total Admins</h5>

                                        <div class="d-flex align-items-center" style="margin: auto;">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <img src="data:image/jpeg;base64,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" width="80" alt="">
                                            </div>
                                            <div class="ps-4">
                                                <h6><%=ta%></h6>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div><!-- End Sales Card -->

                            <!-- Revenue Card -->
                            <div class="col-xxl-4 col-md-6">
                                <div class="card info-card revenue-card">

                                    <div class="card-body">
                                        <h5 class="card-title">Total Members</span></h5>

                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQDxAQEBAQEBAQEA8QDw8QDxAPDQ8QFRUWFxURFRUYHSggGBonGxUVITEhJSkrLjEuFx8zODMsNygtLisBCgoKDg0OGhAQFy0mICUtLS0rKy0tLS0yKy0tLS0tLS8rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAOsA1wMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAAAQMFBgcEAgj/xAA9EAABAwIDBAcGBAUEAwAAAAABAAIDERIEBQYhMUFREyIyYXGBkQdCUqGxwRQjctEzYoKS8BYkwvFDc+H/xAAaAQACAwEBAAAAAAAAAAAAAAAABQIDBAEG/8QAMhEAAgEDAQQIBQUBAQAAAAAAAAECAwQRIRIxQVETYXGRobHR8AVSgcHhFCIjMjNC8f/aAAwDAQACEQMRAD8A2lCEIAEIQgAQhCABCEIAEIQgAQhRmbZ3BhtjyXPIqI27X05ngB4qUYyk8RWWRnOMFtSeF1kmhU6TXBr1YBT+aQ1+QXuDXDa/mQEDm14cfQgfVaHZ1vl8V6mRfEbZvG34P0LchcGX5zBOKxvB5tOxw8Qu4FZpRcXho2RkpLMXlCoQhcOghCEACEIQAIQhAAhCEACEIQAIQhAAhCEACF4kla3tOa39Tg36pI8TG7sva79L2n6IDI4hCEACEIQBH59mQw2HdJsLtjYwdxcd3ptPkstmmc9znOJc5xJc47STzVu9o0x/27OH5jj49UD6n1VKuTmxgo0trizz3xKo51tjhHHe1kcuSXJuqS5bci/A/DO5jg5pII4hXbS2pOlrHIeu3Z4qg3JrB4sxYxhB7TW19SEvv4JwU+XkNfhdRqo6fBrP1X4ybg11Uqj8qxF7GnuUglI8BCE0/ExtNHPa08i5oPzKAHULyyVruy5rvAg/RekACEIQAIQhAAhCEACEIQAKn6n1O5r3QYc0Ldkko2kO4tHKnEqx55jOgw00o3tYbf1nqt+ZCyUv/wC+KYWNCM25y4ef4FfxK5lTSpweG976vyPSSlxLnEuJ3ucS5x8yvKauSXJtkQbK5E3luocRAR1y9nFjjds7idoV2yfP45xvo7iDvWW3Ijx7oJY5GmgLrHfUfdL72hFwc0tVv60Nvh1zJTVOTynu6n+eRtIKVRmS44SxtdzAUmlI9Kb7R8MSyCUbo3Oa7uuoQfVtPNUO5bJmWDbNE+J4q14oR9x3rJM4y5+GkLHbRU2O4OH7prZVk49G963dgk+I27U+lS0e/t3eKwclyS5N3JLlvFuBy5R0MvSYsW7Q2jAedN/zK8ZnjCPy2do7yPdH7qe0bkZJD3BK72un/Gvr6Dj4dbOP8svp6+neaXp6vRt8ApqedsbHPebWsBc4ngAuHLYLWhQftBxpbHFCD/FJc/va2lB6mv8ASslGn0k1Hmb7ir0VNz5ee5eOCFzrUk2IcQ1zo4uDGmhcObiN/huUHVN3JLk/hCMFiKwjy1SUqktqby/fcPRylpq0lpHFpIPqFYso1ZKwhsxvb8R7Y/dVa5JVQq041ViS+vInQrToyzB/Tg+017AZgyZoc0g1XYso0rnDocQYieq4hw81qOHluaCkE4uMnF8D1UJqcVJbnqPIQhRJAhCEACEIQBBa2aTgZacDET4XtWYly2XHYZssUkbuy9jmnnQjesczDCPgldE8dZp38HDg4dxTSwqLZcevPghL8UpvbjPhjHdn1G7klyauRcmArwO3KPziSjG8zK2noV0ufQVJoBtJ4BRIc7EzNDQbWmjfuVku6qjTa4s3WFFzqqXCOrNW0NOTE3wV0aVUdJ4QxxtHcpvO85iwcPSSGpOyOMduR3Id3M8EnUXJ4Q/lJRTbeiOrMMwiw8ZlmeGMHE73H4WjeT3BZdqfUhxbqNYI4geqDQyu73Hh4D1KjM6zmbFymSV3MMYP4cbeTR995UfcmtC1VPWWr8hLc3kqn7Y6R8We7kly8XJLlryYcBBhoxKHnYCau4jxWrabhjLGllKUG5ZRcpXIc+kwrxQksrtby7wsFxaqX7ob+Xv32DK1vXHEKj058vfvq2mNtAqN7RwRNAeBjcB4h236hWfJM5jxDA5pG0Lj1tlZxGHDmCskRL2ji4EdZv0PkFltZqFVN9htvabqUJRjv39xmlyS5NFyS5PDzeEPXLzcmrkzi8UI2lx8AOJPJRlJRWWSjByaUVqxIZqYxlODWA+O0/cLZcklrG3wCxnS+CfLNedpJqStmyeK1oCQ1Z7c3Lmeoo0+jpxhyRLIQhVlgIQhAAhCEACqWu8DAYukke2N4r0Z3vcfhA3ldOqdVR4MdGykmII2M9yMHc537bz3LLsfj5Z5DJM8veeJ4DkBuA7gtltbyk1NvC8xfeXUIp08ZfgvzyweLkly8XLzcm2RLg5szD3ANaOqT1iN/cPBW3R2QgAOI2qt3Kx6Y1F0LgyTsnc7kl13byk9ta9XoNbK5hFdHLTr9TR47MPE6WQ2sjaXOPIBZFqDOpMZO6V9QOzFHXZHHwb48SeatftHz1roIMPG7ZKekkp8LT1GnxdU/wBAWfXLtlSSjt8X5HL+q3Lo1uW/t/H5HLklybqkuW4X4Hbl5uTVyS5cO4HrklyauXm5B3BN5BnT8NICD1SdoWvZRmTMRGCDWoWC3KfyzOMRBEWMeWF3vDtNHdyPesVxbOclKPHf6m+2u1Tg4z4bvT3uJ/W+EginPRvb0jjWSNu2neeR7lWLk2X8eJ2k7yTzSXLZTjsRUc5F1afSTcsYzwXv3yHLlH/hZJpwHCg3N4ii6rl6jlLSCDQhQuKTqw2U8FtrWVGe01n7dhoWmMlEbW7NqumHitCpOkdSsfSOSjXj0PeFeo3gioSaUXF4kh/CcZx2ovQ9oQhRJAhCEACrOtNSjBxiOOhxEgNg3iNu7pCPoOfgp/HYtkMUkzzRkbHPdzoBWg7+CwvNMxfiZpJpD1pHVpwaODR3AUHktVrRU5ZluXiY7y4dOOzHe/D3uG5Zi5xc4lznElznGrnE7yTxK83Ju5d+AwQcL37jubz7ymy1EcmorLOO5eSVYWgN2AADkBRBdVT2Crpeor1yS5SmLwDHgltGO4Edk+IUF01HOY4Ue00IUHoXQxJaHjMnvqJLi4NaGlp20YCSCPUpIZw4VCeuUTIehloOw/a3u5j/ADmqn+3sL4/v04kncluXO2SqW5SyRwPXLzVN3JLlw7gcqkuTdycwzau7htXQxg68NHTrHfwHJP3Ju5JcpFTWRy5Fy7cLl1RV5I/lG/zK7Bg4h7g86lTUWVOpFPBC3JLlLyYCI8C3vBP3UTj8M6LrdpnxcW+I+641jUlCcZPAjJC0ggkEbQRvC0LR2q7qRSnburzWbB9V6imLXBzTQhZq9FVY9fA221Z0ZZ4cT6GikDhUL2qVonUHSsDHHrDYro01SceIVCEIAp3tTxpjwTYx/wCaVrXfoYC8/MNWS3LRfbC40wY4VxHrSNZtcmtppSQmvNaz6seWfudOGbc9reZ2+G8qfuVfyx/5rf6voVOXLdAW1s5HLklyauSXKRVgduVY1e2x0Mw2VJhd3+836OViuVd1tIPw7BxM7aeTXVVNb/Ns0Wy/lj3DGHnuAK5s5bWIu4sIcPofkVz5dJ1V1Y3bFIOcbvoqc7UPobMbM1jmc+Bnq0LsuUXlsD6bipCxw3gqqnWi1qy6rQkpaRZ7uSVXnbySbVZ0kea7yvopfK+5nq5dmE2NrzK4aFdkJo0DuUoTjJ4TIVKcorLR03LsyqK59TuZt8+CjrlK5Meo79X2V0dWZqmkWSlyLk1ci5XZMiQ5cvEgDgWkVBBBB3EHeF4uSXLh3BTi8wzyQk1sdRpPFp2t+RC7g9Rmpn0xuzjFET49YfQBPwSVAWKEsNx5DOSzGM+aLFpvMDDO3bsJW2ZVib2NPML55gko9p71tmkJyYW+AS65WKrGtq80l3eJaUJAhUGgoHthj/2+Gf8ADK9n9zCf+Cyq5bzrDIW47DdE5zmFjxKxzQDR4a4CoO8UceSxHNcnmw7y14qAdjgDQ+SYW1WKhst6i27ozc9pLTQ5I5S1wcN4IKsMM4e0Oadh/wAoquSujL5pGvowFwPbbw/VXgVujLAunT2l2FiuSXJsuSXK0zYPbngAkmgG0k7ABzVDz7NPxUwt/hR1Ef8ANXe/zoPIKW1hPKI2sa0iJ38R43dzDyH12BQOCg4rFXqOT6NDG0pRhHpXv4dXvy7TvwQoAuwnYmI2rpghc4gAEqudSMINZ1L6dOc5qWNC7aKylkjes0FXJ+jYXDshQWmJW4WEPkBqey33nH7eK6sXqfEvPVf0TeDWAV83HastG1nVWVous03F7SoPZlq+S+/Ifl0JFyTP+g4+S5BnuKG3p5PM1HoVI4HV8zCBKGyt4mgY75bD6K6Xw+otzTKIfFaMnhpr31M8x6GiHBUbV2AGGxkkQ2ACNw8C0feq2nLM3hnALSPA7CFUfaLpL8Q78VE8iQMaxzCKxuDa0IptB296pt5qnN7WnA0XMHVprY14mVXLuyjEUcWH3to8Rw/zkuHEYd8ZIe0ghc5dy3jceIKaRknqhVOm/wCsi23JKqLy3Mek6jtjwK14OHPuK7rlcmmsoxyi4vDHbk3iMQ2NrnvIa1oJcTwCS5UnU2ameQwsqI43UPC943k9w4evJV1aqpxzx4FtCg6sscOJyYnFnEYh8pFLj1R8LRsaPQKWgOxReCgopRgWOD2dZsZTjtYjBbjqw217fELadHNpE3wCx/KMG98jaA0qtr01DbG0HkFhrSUpto30YuMEmWNqEBCrLRSFE5pkkU4NzRXwUsq9rHUbcFEA2jsRID0bTtDRxkd3DgOJ81KMXJ7KITnGEXKW4oWrcgwuHNt1ZHbRG3eB8R5D6qvRMa0UaAB9V6nnc9znvcXveS5znGrnE8Sm7k4oUFSWm8Q3FxKtLL0XIduSXJq5FyuKMHt1CCCAQdhB2gjkowZOy/qmjSez8Ph3LvuSXKurSjUjhl1GrOlLaj3E9lWjA8A1qFa8s0jGynVVa0rqEwvDHmrTuJ+i1CPEtfC9zDtscR42miT1KTpy2WPqVWNSO0jNMyxAfK63sNJazlQbj57/ADXJcmg7Yiq9BGKilFcDykpObcnveveOXJLk3ckuXcnMD8ePfARI00tIuHNu5aXkeYtxMQJ21G1ZNjnflS/+t/0Vo9nWMNoFUov4pVE+aH3wyTdJxfBlnzfSsM1TaKrO9S6dw+HfZeS/fY3aWjmeSvesdVjCt6GEg4hw2u3iFp4kcXHgPM8K5fJKXEucS5ziS5xJLiTvJPErltbbX75biV3d7H7Ib/ISKNrBRoAHzPivdybLklyaCbeO3KNzLK45jdS2Qe+Bv7n812XJLlGUVJYaJwk4vajvPOTaZMuyoqrdl+hmil21VnBY18Tw9p3bxwK1LS2fR4hgBoHcRxSivQdJ54Dy2uVVWNzXA8ZbppkdKNHorHhMKGBdLAOC9LOagQhCAGcZiWRRvleaMjY57j3AVKwzOMzfip5J5O087G1qGMHZYO4D7rSfajjTHgWxg7Z5GsP6GgvPza31WS3JlZQxFz56Cq/m3JQ4LXv/AAO3JLkzci5bRfgduSVTVyS5B3A7cvNybuRcuZO4Pdyu+iNRFpETzUbhVUOqcw+ILHBwO4hZrqCnTfNa+vvqNVpUcKi5PT099Zac1wphmfHwBqw82nsn0+hXFVWtmGGOwzSP4jB1XcfA9yqMrS1xad7SQaGoqFdb3Cqx61v9TNd2roy0/q93oe7l5uXi5c2NxPRsLqVO4cq96vlJRTbM8abnJRS1Y1m+K2dE3tOpd3M/+qyZDi/wWFdORV2xsbT70h3Dw3k9wKgdN5Q6eS91TU1JPFSWtHWyxYcdmKMPcP53/s0D+4pPtO4rZa0+3/o92Fa0MR3/AHZESYh0jnPe4ue8lznHe5x3lJcmgUlyaifA5ci5NXJLkBgduSVTVyS5B3A7curLcwdBIHtJG3aOaj7klyjNKS2XuZOEnGSlHejcNM503ERg1202qfCxTRubmKYNrsK2PBTh7Qe5JJxcZOL4D+E1OKkuJ0oQhRJGde2F5twY4VxB8wI/3KzS5af7YY/yMM/4ZXs/uZX/AILK7k1tf8l9fMTXkf5n9PIcqkqvFyS5XmfB7uRcm7l5uQdwO3IuTNyS5AYHbkoBOwCpO5NMqSANpKlcNCGDmTvKNnaWDjlsaknhcwljh6Jry0Edct2E91eS5bl4uSXKUIRprEUVVJyqS2pvLHLl5JqvFyS5TI4LFpbNI4XBjwACdh4eCiNXYgPzDEuBqLowPAMYPsuO5R2YRuBMrST8Y3nYKXDyWZUY05Oce735Gzp5VIKE+D3+vqO3JLlzxThwqE5erc5Kdnme6pKpu5Fy4dwe7kXJu5ebkHcDtyC5M3JLkBg68JLbIwjmtu0tibom+AWEQGr2+K2rRv8ACb4BKrn/AEY4tf8AJfXzLcEIahUGggdbZCMdheivMbmSCVjg0OFwa5tCOVHFYlmeWTYd5ZI3d7wqWlfRZChs30/FODc0V50V1KvKmsLcUVbeFR5e8+fbkly07NPZ8KksVcxWiJ27hValeR4pmV2UuDRVLkXKak0viB7pTJ07P8B+al+rp9fcR/R1OrvIm5Jcphmmpz7pT7tMSsY6R4o1gLj4KP6uL0imS/SSWraOHARUFx3u3dwXXcm7kly37hW9Xk93IuTVyS5AYHbklU1ckuQdwPXJLkzci5cyGCKxbehkBHYednJruIT7ZKp7GRCRjm+Y7iNyMtyqR7eqKrNUqqlLXczZSpSrR03oaqkuXbLlMzd7D6LndgpB7p9EK4p/N5kna1Pl8hq5Fy9fhJPhPovbcBIfdK5+pp8wVrU5eQxckuUjDkkztzD6KWwWkJX0qKKqV3H/AJRdGyk/7P7kHlrLpG+K23S0dI2+AVZybRzWEEipV8y3CWABYpycpOTN0IqMVFEi1CUIUSQIQhAHktBTb8O08E8hAHG7AMPAeibOWM+EKQQgCPGWM5BV/wBoGHEeW4ggUJMTfIyMqrgq37Ro7srxP8oif/bIwn5Kyl/pHtRVX/zl2PyMUuRcmrklyc5EWB65eapu5JcuHcDlUlybuSXIDA7cvN6auSXIO4HrlatByDpLTuqqdcrToQfm171ivP8An6jCxTzL6GsMymJ47I9E0/TcJ9weilcB2R4LrWAYFb/0xF8A9F7ZpyIe6PRWFCAIePJWD3R6Lqjy9o4BdyEANMgA4JwBKhAAhCEACEIQAIQhAAhCEACj9QYE4jCYiBpAdLE9jS6tocRsJpwrRSCF1PDycaysHznmmWzYZ5ZMwtIO8dZh7wQuC5b5n2nIsSDUbeaz7NdAvaSWLbG8+ZdxgnY/K+/1KJckqpnFaZxDPdXBJlUw3sPorVdU3xKnaVFw8UclyS5PHASfCfRAy+U+6V13NLmcVrU5eKGbl5uXfHk8x9wrvw2l53e6QoSu4cEyyNnN72kQNVd9AQG6tE9luiDsL1d8lyFsNKCix1arqPU20aKprCLFgh1QupNwsoE4qi0EIQgAQhCABCEIAEIQgAQhCABCEIAEIQgAQhCABeHRgr2hAHJLgGO3gLkkyOI+6FLIQBBO03F8LUg03H8LVPIQBDsyKMe6F0R5Y0cApBCAOdmFaE81gC9IQAIQhAAhCEACEIQAIQhAAhCEAf/Z" width="80" class="ps-3" alt="">
                                            </div>
                                            <div class="ps-4">
                                                <h6><%=tm%></h6>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div><!-- End Revenue Card -->

                            <!-- Customers Card -->
                            <div class="col-xxl-4 col-xl-12">

                                <div class="card info-card customers-card">

                                    <div class="card-body">
                                        <h5 class="card-title">Customers <span>| This Year</span></h5>

                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-people"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>1244</h6>
                                                <span class="text-danger small pt-1 fw-bold">12%</span> <span class="text-muted small pt-2 ps-1">decrease</span>

                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div><!-- End Customers Card -->

                            <!-- Reports -->
                            <div class="col-12">
                                <div class="card">

                                    <div class="card-body">
                                        <h5 class="card-title">Announcement <span>| Latest</span></h5>
                                        <h5 class="text-primary fw">Subject</h5>
                                        <p><%=subs%></p>

                                        <h5 class="text-primary fw">Description</h5>
                                        <p><%=mess%></p>

    
                                    </div>

                                </div>
                            </div><!-- End Reports -->

                        </div>
                    </div><!-- End Left side columns -->

                    <!-- Right side columns -->
                    <div class="col-lg-4">

                        <!-- Recent Activity -->
                        <div class="card">

                            <div class="card-body">
                                <h5 class="card-title">Recent Members</h5>

                                <div class="activity">
                                    <%
                                    String cols[]={"success","danger","primary","info","warning"};
                                    for (int p=0;p<o;p++){%>
                                    <div class="activity-item d-flex ">
                                        <div class="activite-label" style="font-weight: 700"><%=flatnos[p]%></div>
                                        <i class='bi bi-circle-fill activity-badge text-<%=cols[p]%> align-self-start'></i>
                                        <div class="activity-content" style="font-weight: 700">
                                           @<%=usernames[p]%> 
                                        </div>
                                    </div><!-- End activity item-->
                                    <%}%>
                                    
                                </div>

                            </div>
                        </div><!-- End Recent Activity -->

                    </div><!-- End Right side columns -->

                </div>
            </section>

        </main><!-- End #main -->


        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                class="bi bi-arrow-up-short"></i></a>


    </body>
    <script>
        $(function () {
            $('.changeformat').hide();
            $('.cfb').click(function () {
                $('.changeformat').toggle('slow');
            });

        });
    </script>


    <script>
        (function () {
            "use strict";

            /**
             * Easy selector helper function
             */
            const select = (el, all = false) => {
                el = el.trim()
                if (all) {
                    return [...document.querySelectorAll(el)]
                } else {
                    return document.querySelector(el)
            }
            }

            /**
             * Easy event listener function
             */
            const on = (type, el, listener, all = false) => {
                if (all) {
                    select(el, all).forEach(e => e.addEventListener(type, listener))
                } else {
                    select(el, all).addEventListener(type, listener)
            }
            }

            /**
             * Easy on scroll event listener 
             */
            const onscroll = (el, listener) => {
                el.addEventListener('scroll', listener)
            }

            /**
             * Sidebar toggle
             */
            if (select('.toggle-sidebar-btn')) {
                on('click', '.toggle-sidebar-btn', function (e) {
                    select('body').classList.toggle('toggle-sidebar')
                })
            }

            /**
             * Search bar toggle
             */
            if (select('.search-bar-toggle')) {
                on('click', '.search-bar-toggle', function (e) {
                    select('.search-bar').classList.toggle('search-bar-show')
                })
            }

            /**
             * Navbar links active state on scroll
             */
            let navbarlinks = select('#navbar .scrollto', true)
            const navbarlinksActive = () => {
                let position = window.scrollY + 200
                navbarlinks.forEach(navbarlink => {
                    if (!navbarlink.hash)
                        return
                    let section = select(navbarlink.hash)
                    if (!section)
                        return
                    if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
                        navbarlink.classList.add('active')
                    } else {
                        navbarlink.classList.remove('active')
                    }
                })
            }
            window.addEventListener('load', navbarlinksActive)
            onscroll(document, navbarlinksActive)

            /**
             * Toggle .header-scrolled class to #header when page is scrolled
             */
            let selectHeader = select('#header')
            if (selectHeader) {
                const headerScrolled = () => {
                    if (window.scrollY > 100) {
                        selectHeader.classList.add('header-scrolled')
                    } else {
                        selectHeader.classList.remove('header-scrolled')
                    }
                }
                window.addEventListener('load', headerScrolled)
                onscroll(document, headerScrolled)
            }

            /**
             * Back to top button
             */
            let backtotop = select('.back-to-top')
            if (backtotop) {
                const toggleBacktotop = () => {
                    if (window.scrollY > 100) {
                        backtotop.classList.add('active')
                    } else {
                        backtotop.classList.remove('active')
                    }
                }
                window.addEventListener('load', toggleBacktotop)
                onscroll(document, toggleBacktotop)
            }

            /**
             * Initiate tooltips
             */
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            })

            /**
             * Initiate quill editors
             */
            if (select('.quill-editor-default')) {
                new Quill('.quill-editor-default', {
                    theme: 'snow'
                });
            }

            if (select('.quill-editor-bubble')) {
                new Quill('.quill-editor-bubble', {
                    theme: 'bubble'
                });
            }

            if (select('.quill-editor-full')) {
                new Quill(".quill-editor-full", {
                    modules: {
                        toolbar: [
                            [{
                                    font: []
                                }, {
                                    size: []
                                }],
                            ["bold", "italic", "underline", "strike"],
                            [{
                                    color: []
                                },
                                {
                                    background: []
                                }
                            ],
                            [{
                                    script: "super"
                                },
                                {
                                    script: "sub"
                                }
                            ],
                            [{
                                    list: "ordered"
                                },
                                {
                                    list: "bullet"
                                },
                                {
                                    indent: "-1"
                                },
                                {
                                    indent: "+1"
                                }
                            ],
                            ["direction", {
                                    align: []
                                }],
                            ["link", "image", "video"],
                            ["clean"]
                        ]
                    },
                    theme: "snow"
                });
            }

            /**
             * Initiate TinyMCE Editor
             */
            const useDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
            const isSmallScreen = window.matchMedia('(max-width: 1023.5px)').matches;

            tinymce.init({
                selector: 'textarea.tinymce-editor',
                plugins: 'preview importcss searchreplace autolink autosave save directionality code visualblocks visualchars fullscreen image link media template codesample table charmap pagebreak nonbreaking anchor insertdatetime advlist lists wordcount help charmap quickbars emoticons',
                editimage_cors_hosts: ['picsum.photos'],
                menubar: 'file edit view insert format tools table help',
                toolbar: 'undo redo | bold italic underline strikethrough | fontfamily fontsize blocks | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | charmap emoticons | fullscreen  preview save print | insertfile image media template link anchor codesample | ltr rtl',
                toolbar_sticky: true,
                toolbar_sticky_offset: isSmallScreen ? 102 : 108,
                autosave_ask_before_unload: true,
                autosave_interval: '30s',
                autosave_prefix: '{path}{query}-{id}-',
                autosave_restore_when_empty: false,
                autosave_retention: '2m',
                image_advtab: true,
                link_list: [{
                        title: 'My page 1',
                        value: 'https://www.tiny.cloud'
                    },
                    {
                        title: 'My page 2',
                        value: 'http://www.moxiecode.com'
                    }
                ],
                image_list: [{
                        title: 'My page 1',
                        value: 'https://www.tiny.cloud'
                    },
                    {
                        title: 'My page 2',
                        value: 'http://www.moxiecode.com'
                    }
                ],
                image_class_list: [{
                        title: 'None',
                        value: ''
                    },
                    {
                        title: 'Some class',
                        value: 'class-name'
                    }
                ],
                importcss_append: true,
                file_picker_callback: (callback, value, meta) => {
                    /* Provide file and text for the link dialog */
                    if (meta.filetype === 'file') {
                        callback('https://www.google.com/logos/google.jpg', {
                            text: 'My text'
                        });
                    }

                    /* Provide image and alt text for the image dialog */
                    if (meta.filetype === 'image') {
                        callback('https://www.google.com/logos/google.jpg', {
                            alt: 'My alt text'
                        });
                    }

                    /* Provide alternative source and posted for the media dialog */
                    if (meta.filetype === 'media') {
                        callback('movie.mp4', {
                            source2: 'alt.ogg',
                            poster: 'https://www.google.com/logos/google.jpg'
                        });
                    }
                },
                templates: [{
                        title: 'New Table',
                        description: 'creates a new table',
                        content: '<div class="mceTmpl"><table width="98%%"  border="0" cellspacing="0" cellpadding="0"><tr><th scope="col"> </th><th scope="col"> </th></tr><tr><td> </td><td> </td></tr></table></div>'
                    },
                    {
                        title: 'Starting my story',
                        description: 'A cure for writers block',
                        content: 'Once upon a time...'
                    },
                    {
                        title: 'New list with dates',
                        description: 'New List with dates',
                        content: '<div class="mceTmpl"><span class="cdate">cdate</span><br><span class="mdate">mdate</span><h2>My List</h2><ul><li></li><li></li></ul></div>'
                    }
                ],
                template_cdate_format: '[Date Created (CDATE): %m/%d/%Y : %H:%M:%S]',
                template_mdate_format: '[Date Modified (MDATE): %m/%d/%Y : %H:%M:%S]',
                height: 600,
                image_caption: true,
                quickbars_selection_toolbar: 'bold italic | quicklink h2 h3 blockquote quickimage quicktable',
                noneditable_class: 'mceNonEditable',
                toolbar_mode: 'sliding',
                contextmenu: 'link image table',
                skin: useDarkMode ? 'oxide-dark' : 'oxide',
                content_css: useDarkMode ? 'dark' : 'default',
                content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
            });

            /**
             * Initiate Bootstrap validation check
             */
            var needsValidation = document.querySelectorAll('.needs-validation')

            Array.prototype.slice.call(needsValidation)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }

                            form.classList.add('was-validated')
                        }, false)
                    })

            /**
             * Initiate Datatables
             */
            const datatables = select('.datatable', true)
            datatables.forEach(datatable => {
                new simpleDatatables.DataTable(datatable);
            })

            /**
             * Autoresize echart charts
             */
            const mainContainer = select('#main');
            if (mainContainer) {
                setTimeout(() => {
                    new ResizeObserver(function () {
                        select('.echart', true).forEach(getEchart => {
                            echarts.getInstanceByDom(getEchart).resize();
                        })
                    }).observe(mainContainer);
                }, 200);
            }

        })();
    </script>

</html>
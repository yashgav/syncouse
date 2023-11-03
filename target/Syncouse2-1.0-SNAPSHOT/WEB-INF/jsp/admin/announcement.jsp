<%-- 
    Document   : announcement
    Created on : Mar 17, 2023, 3:44:49 AM
    Author     : Yash
--%>
<%@page import="java.sql.*"%>
<%
    String user=(String) request.getAttribute("user");
    String scode=(String) request.getAttribute("scode");

    Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            PreparedStatement stmt1 = con.prepareStatement("select * from ANNOUNCEMENT WHERE SCODE=?");
            stmt1.setString(1, scode);
            
            ResultSet rs = stmt1.executeQuery();
            String byuser=null,sub=null,mess=null;
            while (rs.next()) {
                byuser = rs.getString("USERNAME");
                sub = rs.getString("SUBJECT");
                mess = rs.getString("MESSAGE");
            }
            int oo=0;
            if(sub!=null){
            oo=1;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Syncouse | Announcements</title>
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
        .pbtns{
            background: none;
            border: none;
            padding: 0;
            margin: 0px;
            padding: 10px;
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
                            <span class="d-none d-md-block dropdown-toggle ps-2">${un}</span>
                        </a><!-- End Profile Iamge Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                            <li class="dropdown-header">
                                <h6>${un}</h6>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <form action="admin_personal_profile" class="nav-link collapsed" >
                                    <button name="user" value="${un}" type="submit"  class="pbtns">
                                        <i class="bi bi-person"></i>
                                        <span>My Profile</span>
                                    </button>
                                </form>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <form action="signout" class="nav-link collapsed" >
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
                    <form action="admin_home" class="nav-link collapsed" >
                        <button type="submit" class="sidebut">
                            <i class="bi bi-speedometer2"></i>
                            <span>Dashboard</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="admin_members" class="nav-link collapsed" >
                        <button type="submit" class="sidebut">
                            <i class="bi bi-person-vcard"></i>
                            <span>Members</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="admin_payments" class="nav-link collapsed" >
                        <button type="submit" class="sidebut">
                            <i class="bi bi-currency-dollar"></i>
                            <span>Payments</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="admin_announcement" class="nav-link " >
                        <button type="submit" class="sidebut">
                            <i class="bi bi-megaphone"></i>
                            <span>Announcements</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->
                <li class="nav-item">
                    <form action="admin_complaints" class="nav-link collapsed" >
                        <button type="submit"  class="sidebut">
                            <i class="bi bi-file-earmark-text"></i>
                            <span>Complaints</span>
                        </button>
                    </form>
                </li><!-- End Dashboard Nav -->


                <li class="nav-heading">Pages</li>

                <li class="nav-item">
                    <form action="admin_personal_profile" class="nav-link collapsed" >
                        <button name="user" value="${un}" type="submit"  class="sidebut">
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
                    <form action="signout" class="nav-link collapsed" >
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
                <h1>Announcement</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html">Admin</a></li>
                        <li class="breadcrumb-item active">Announcement</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->

            <section class="section profile">
                <div class="row">

                    <div class="card">
                        <div class="card-body">
                            <h5 align="left" class="card-title">Make Announcement</h5>
                            <form action="announced" class="">
                                <div class="row">
                                    <div class="mb-3 col-lg-12 ">
                                        <label for="validationCustomUsername" class="form-label">Subject</label>
                                        <div class="input-group has-validation">
                                            <input type="text" name="sub" class="form-control border-black"
                                                   id="validationCustomUsername" aria-describedby="inputGroupPrepend"
                                                   placeholder="general maintainance charges" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="mb-3 col-lg-12 ">
                                        <label for="validationCustomUsername" class="form-label ">Description</label>
                                        <div class="input-group has-validation">
                                            <textarea class="form-control border-black" name="message" style="height: 200px" placeholder="Description of announcement ( Not more than 500 letters)"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class=" d-flex justify-content-start btns mt-3 mb-3">
                                    <button class="btn btn-outline-danger ms cfb" type="reset">Reset</button>
                                    <button class="btn btn-outline-primary ms-3" type="submit">Announce</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
                <div class="row">

                    <div class="card">
                        <div class="card-body">

                            <h5 class="card-title">Last Announcement</h5>
                            <h5 class="text-primary">Subject</h5>
                            <p><%=sub%></p>

                            <h5 class="text-primary">Description</h5>
                            <p><%=mess%></p>


                        </div>
                    </div>

                </div>
            </section>

        </main><!-- End #main -->


        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                class="bi bi-arrow-up-short"></i></a>


    </body>


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
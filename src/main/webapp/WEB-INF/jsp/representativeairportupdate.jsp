<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>

<html>
    <head>
        <meta charset="utf-8">
        <title>Representative</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${user != null}">
                <c:choose>
                    <c:when test="${user.role() == 'REPRESENTATIVE'}">
                        <h1>Add an airport</h1>
                        <p>To edit an airport, enter a valid id number. Fields may be left blank if you don't want to edit those.</p>
                        <p>${message}</p>
                        <form action="/representativeairportadd" method="POST">
                            ID: <input type="text" name="id"/>
                            Name: <input type="text" name="name"/>
                            <input type="hidden" name="_method" value="PUT"/>
                            <input type="submit" value="Update"/>
                        </form>
                        <a href="/customerrep">Return to representative page</a>
                        
                    </c:when>
                    <c:otherwise>
                        <h1>Unauthorized Access</h1>
                        <p>You do not have access to this page.</p>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <h1>Please login to access this page</h1>
                <a href="/login">Return to login</a>
            </c:otherwise>
        </c:choose>
    </body>
</html>

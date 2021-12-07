<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>

<html>
    <head>
        <meta charset="utf-8">
        <title>Questions and Answers</title>
    </head>
    <body>
        <c:if test="${user != null}"> <!--We can see that the user is not null-->
            <h2>Logged in as: ${user.first_name()} ${user.last_name()}</h2>
        </c:if> 
        
        <c:choose>
            <c:when test="${user.role() == 'REPRESENTATIVE'}"> <!--User is a represenative, will be able to respond to questions-->
                <h1>Questions and Answers</h1>
                <c:forEach var="item" items="${qlist}"> <!--For every item in the answer list-->
                    <h3>Question: </h3>
                    ID: ${item.id()} <br>
                    Title: ${item.title()} <br>
                    Content: <br>
                    ${item.body()}
                    <br>
                    <br>
                    <c:forEach var="item2" items="${alist}"> <!--For every item in the answer list-->
                        <c:if test="${item2.qid() == item.id()}">
                            <h3>Answer: </h3>
                            Content: <br>
                            ${item2.body()}
                            <br>
                            <br>
                        </c:if>
                    </c:forEach>
                </c:forEach>

                <!--Form for allowing represenatives to answer questions-->
                <form action="/login" method="POST">
                    QuestionID: <input type="text" name="qid"/>
                    Answer: <input type="text" name="abody"/>
                    <input type="submit" value="Submit"/>
                </form>

            </c:when> 

            <c:when test="${user.role() == 'CUSTOMER'}"> <!--User is a customer-->
                




            <form action="/login" method="POST">
                Question: <input type="text" name="qid"/>
                <input type="submit" value="Submit"/>
            </form>
            </c:when> 
        </c:choose>
    </body>
</html>

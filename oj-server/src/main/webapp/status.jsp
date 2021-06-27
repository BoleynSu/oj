<%@page import="java.awt.List"%>
<%@page pageEncoding="utf-8" language="java"
	import="su.boleyn.oj.server.User,java.sql.ResultSet"%>
<%
	User user = new User(request, response);
	ResultSet rs = null;
	try {
		rs = user.searchSubmission();
		if (!rs.isBeforeFirst()) {
			user.go("No such page.", "/status?cid=" + user.get("cid"));
		}
	} catch (Exception e) {
		user.go("No such page.", "/status?cid=" + user.get("cid"));
	}
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Boleyn Su's Online Judge - Status</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
html, body {
	height: 100%;
}

#wrap {
	min-height: 100%;
	height: auto !important;
	height: 100%;
	margin: 0 auto -42px;
	padding: 0 0 42px;
}

#footer {
	background-color: #f5f5f5;
	border-top: 1px solid #e5e5e5;
}

#body {
	padding-top: 40px;
}
</style>
<link rel="stylesheet" href="/webjars/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/webjars/bootstrap/3.4.1/css/bootstrap-theme.min.css" />
<script src="/webjars/jquery/3.6.0/jquery.min.js"></script>
<script src="/webjars/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="/static/my.js"></script>
</head>
<body>
	<div id="wrap">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<header class="page-header">
						<h2>Boleyn Su's Online Judge</h2>
					</header>
					<nav>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="/">Home</a></li>
							<li><a href="/problemset">Problem set</a></li>
							<li><a href="/submit">Submit</a></li>
							<li <%if (!user.isContest()) {%> class="active" <%}%>><a
								href="/status">Status</a></li>
							<li><a href="/standings">Standings</a></li>
							<li><a href="/contests">Contests</a></li>
							<li><a href="/login">Login</a></li>
							<li><a href="/register">Register</a></li>
						</ul>
					</nav>
				</div>
				<div class="col-md-8" id="body">
					<%
						if (user.isContest()) {
					%>
					<article class="panel panel-default">
						<header class="panel-heading">
							<h1 class="panel-title"><%=user.getContestTitle()%></h1>
						</header>
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li><a href="/problemset?cid=<%=user.get("cid")%>">Problems</a></li>
								<li><a href="/submit?cid=<%=user.get("cid")%>">Submit</a></li>
								<li class="active"><a
									href="/status?cid=<%=user.get("cid")%>">Status</a></li>
								<li><a href="/standings?cid=<%=user.get("cid")%>">Standings</a></li>
							</ul>
							<%
								}
							%>
							<h3>
								Status<%
								if (user.hasLogin()) {
							%>
								|<small><a
									href="/status?cid=<%=user.get("cid")%>&username=<%=user.getUsername()%>">My
										status</a></small>
								<%
									}
								%>
							</h3>
							<table class="table table-hover table-condensed">
								<thead>
									<tr>
										<th class="col-md-1">#</th>
										<th class="col-md-1">Problem</th>
										<th class="col-md-2">User</th>
										<th class="col-md-3">Submit Time</th>
										<th class="col-md-3">Result</th>
										<!--
										<th class="col-md-1">Time</th>
										<th class="col-md-1">Memory</th>
-->
									</tr>
								</thead>
								<tbody>
									<%
										boolean hasLogin = user.hasLogin();
										while (rs.next()) {
											String result = rs.getString("result");
									%><tr>
										<td>
											<%
												if (hasLogin && (user.getUsername().equals(rs.getString("username")) || user.isAdmin())) {
											%><a
											href="/submission?cid=<%=user.get("cid")%>&sid=<%=rs.getString("id")%>"><%=rs.getString("id")%></a>
											<%
												} else {
											%><%=rs.getString("id")%> <%
 	}
 %>
										</td>
										<td><a
											href="/problem?cid=<%=user.get("cid")%>&pid=<%=rs.getString("pid")%>"><%=rs.getString("pid")%></a></td>
										<td><%=rs.getString("username")%></td>
										<td><%=rs.getDate("submit_time")%> <%=rs.getTime("submit_time")%></td>
										<td><strong
											class="<%=result.startsWith("accepted") ? "text-success"
						: result.startsWith("judge error") ? "text-info"
								: result.startsWith("running") || result.startsWith("waiting") ? "" : "text-danger"%>"><%=result%></strong></td>
										<!--
										<td><%=rs.getString("time")%>ms</td>
										<td><%=rs.getString("memory")%>kb</td>
-->
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
							<ul class="pagination">
								<%
									int cur = 1;
									try {
										cur = Math.max(1, Integer.parseInt(user.get("page")));
									} catch (NumberFormatException e) {
									}
								%>
								<li><a
									href="/status?cid=<%=user.get("cid")%>&page=<%=(cur - 1)%>&username=<%=user.get("username")%>&pid=<%=user.get("pid")%>&result=<%=user.get("result")%>">&laquo;</a></li>
								<li><a><%=cur%></a></li>
								<li><a
									href="/status?cid=<%=user.get("cid")%>&page=<%=(cur + 1)%>&username=<%=user.get("username")%>&pid=<%=user.get("pid")%>&result=<%=user.get("result")%>">&raquo;</a></li>
							</ul>
							<%
								if (user.isContest()) {
							%>
						</div>
					</article>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div class="container">
			<footer class="text-center">
				Boleyn Su's Online Judge is an open source project released under
				MIT license at <a href="https://boleyn.su/source/oj">boleyn.su/source/oj</a>.<br />
				&copy;2013-2020 Boleyn Su. All Rights Reserved.
			</footer>
		</div>
	</div>
</body>
</html>

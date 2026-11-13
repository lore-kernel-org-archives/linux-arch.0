Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559076;
	b=ZZ6hGpvvUsvjy8kYp7ixh94HNpF1cRV24fOz7UcGTYyEj+PVZBKxO11XEeL7ea7xNw5U
	 DY6IveA3BnrmEamLwAvabZZ9q2vzIOKwH0IUErG5wIwqJxN6zawdgFXDvM19hEmi6Pj+F
	 t5UhYs2uMhdV6J/ueBYBiTMWGax2AI7X7/5gQkzNL6f+bayo/tc+9Qp0jyts3TH/tawZb
	 XQbokHh/W2Y6cO19I+x4bhBR9W//qbY/uam6H7+jmElQhFaCp6+K8kvz10THZxsdqUmBZ
	 F87ENmQUu/r+2CGWl4ytjEm7+xpXtdCJTkBxgAhPA3xTjOdCWj4Byn/0fwFxAqYkKMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559076;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=GTlm17xUlVDtPyZIYg3uMmdBtMoPImaAjgb8ueJOTlM=;
	b=Xsq1lj91BBNu9TcnACYa4vPMasJrX0GQOVujf2G8h6iZ80UjMwgZqcaN8YF96NptNDdU
	 qDa04WlfpkbEIUE/p0aWrhRvqDu7pmG8ASkveyKj57jhkncyf3g73siRimYrzcxJHVmW8
	 87Ti6XWpBHNVgEP2nDWUU/H3O8RqvrzlU2QkUSLCYIwJtBTaja7/cH9E0tt7qnGDOjyDw
	 b7c8shadQfHwyodbVJ8d+rbImtmK+QZ6fmSycu7znGzOyV93bhoIxjZvQnf6pOF6ZbxFN
	 Wlq9pRhretcOmpNIabuyg6S9C9WC/6S7ChwljOGESjyNk76F5ZYd2qkHK1pcfhY/Xdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=OPZXyDcL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="B8ZduIz/";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFE606A330
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 08:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67FFE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=OPZXyDcL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B8ZduIz/
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 364F71D00340
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 03:37:54 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 13 Nov 2026 03:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794559072;
	 x=1794645472; bh=GTlm17xUlVDtPyZIYg3uMmdBtMoPImaAjgb8ueJOTlM=; b=
	OPZXyDcLbRwg9FNj96OvkKUok5OI98nlj51Lk9LJTYvkoYZjSrP7mNYi/x9zdkEb
	3uTteB95szLLd/We3JItyZXJLGGrqobfvlK7djTitF639GpSEFxnXcAUozl12b7z
	MLMiKqVDPazwp2RuRMaugnDMdThzNfBku4VW3UtYp15omfallC9lSLWYv8Td+RFJ
	KgVxxj2TU1O+DDJRnp9EbjyA9YpeYp5INFla2b3GeC3Laug8KTzWwLOFFA/Ds4Z5
	TDB9jQ49JP486ptvsID+jGLKATYpNu8oQky9WX6+W3BoUXCWstvLEFvXDvvCYFph
	hibmIXM98K2iI6yu7jne3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794559072; x=
	1794645472; bh=GTlm17xUlVDtPyZIYg3uMmdBtMoPImaAjgb8ueJOTlM=; b=B
	8ZduIz/ZGLjFUgCtIkeD7UbdTbgf5ZWqUuEkgGa06R2O3ve7yKKwzUXqOOjW+4ks
	kg+QPGl/52BxjePcuzNZFCt85rZVSi7RSIpQI6HFnpIbN1NnarghH2G4RP4ZTypk
	qJjQ0HyvBPeKw7P6mnSXQaDqSt6SZAttSB2B4nYtR2F9d+3iVvgOXezU+k2vTw01
	tv92fRTZErcgJHE2ik9ixH+p4MToQet6eMH/H4MEb1E+tVK7BSr9SraMB8HBsT3J
	mxVcWkeDOjxmZmmiFv6qEjcmI2Rid/djXu7Gwiq5PsrQ4kh0doevo1wO00AeR0Rz
	ITWTY/WHhTiYoB4SN37ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794559072; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:Vox983odOiImbfdoJXOLJ4NHxWn0JWc82UxU+U5pisQcLlO
	I1TR4MCriBRQl1hKK9x0w2+tUrBS1ZGy+z1TT6kpbmvbOC2re9tIYzDsc+FzLn1v
	ewmkS+SBOiUTtw8X73AIsyF/Vu8iXzBBA0s6Av0iqW91BsPHPMghqzq+Fxt+jk6d
	aX0YuFW+zoN7rEHhVK8D8nSvPf0v95Oc5Y8wx6cdlZMpXf5vP3DEsqPM8i3dvUn5
	pvmcXfK3u4NuVTCMcEIcCmq5fmBzPc8n36nRiE1dIiB4GQlhXNwIZr2XvuKTjCIi
	qlq52sC91XP44ZVAXAabf08od2+Ee2z/pXJv1eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:07K7iOZfEBkDm1kWIyv6BIKGT60g3OidrwDavL9rNys=:KYAIhyvP+/poZD6uW+BQdTxmjc9zG40me+FHurlnYpI=;
X-ME-Sender: <xms:X8z2ahrQSXBytZGhTvhaQcJruSUB8ZUcbPm_1iOBxBJsfz33ShUDrQ>
    <xme:X8z2aufK61--LtnFHV7paGjJCfsP8AuElKkASbJk6IW0BiwKEfDFLGhdr6NHZe3kz
    zBqt5enYnszMi8eMjMSVx_VlF1jkV5diNXbpcCTeobIcn_I6lnfiljZ>
X-ME-Proxy-Cause: dmFkZTEIf7pvw61zRP9/oHMrUUYzT73bmlwtbaqCWKHHGAgAchGhyIJq8BHrID7VNRL5wL
    jNL4Cf93csqx/fpWy9nwC5BDiE1pjffO2TUl+XB1046dRbONQwmZ557UkzFdB01lytH05o
    bNGuhvxk5yFLWDTWfoZ2VjI5inOIaUyEGGfUU2uETXQKY+YmKF7Mn2ySwr6+oiiF4GM3Vu
    9yXlHwbT3KgqzaKP3Ahpr+AqESaEJvtrZHr4kHun9AD97SzB9B6CjIgrftclLXyEmKjidr
    1w4ItyVDgF0+Pme6SeAFshhZJTH6FAVkh7aqux3e1OKRwLB2tQn0v8hNvswGHrPXz/fdNI
    TCpRTvTW9zWVbaG6/BUWMCDy7ALS2v6mm2zU5LiajS7PddFWWucCkhhX2f0uJJgZUxyARe
    ot4suMpxG/9/bs5EflzBznf4nflv85NmcjIDjWzY004xdvR5X/4VugtALrt56k7bzYM8R5
    mhlJTstaCLNURQx3NdG3wjlUVs13rzSykwJm0s/ITpCzF4nkBpv5bJ4nOaUnGxYtKLvKiq
    mrhPPnII7UcG6PjCV40N2xLcvW9O18zGrRhSrOgkcIsgI4ebBC0MQgSx9gay/B0IxNPXzV
    bcNcNXpaE6zpNUVjGcb9TWDoeargC4lQxYWI/tElwBlDIu0XwJTDr7+bs9pw
X-ME-Proxy: <xmx:X8z2avMi5jYgNCwwN6DvDpK3qmgiuMODjt2xICfMQVjOGtfHkRMpIg>
    <xmx:X8z2aqG0-B-enmsyeQrD3IoWMq17P332Am9rJjtmdBCJFbcq71zNGA>
    <xmx:X8z2amOYbJ8chbJMQjBtSc5No10e-vmKkMjXBaUKju_TSySACceCbQ>
    <xmx:X8z2ar-UmCoDjt7x8yhGHnS1Ww1sOOxc1B381GHKGWWWxoXGW4DK2A>
    <xmx:YMz2amD3toQhkBcT1DvmjTdWgRpDaobrdMgFvjT884P3Sh5HxyUQY1Zv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 04A4B32A0099; Fri, 13 Nov 2026 03:37:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A7VJXCM52kA3
Date: Fri, 13 Nov 2026 09:37:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Safocl Stollmannovic" <safocl88@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <a37c1534-f1d4-4c0c-8aba-955d0742b7b1@app.fastmail.com>
In-Reply-To: <20261113001432.128201-10-safocl88@gmail.com>
References: <20261113001432.128201-1-safocl88@gmail.com>
 <20261113001432.128201-10-safocl88@gmail.com>
Subject: Re: [PATCH 09/10] sched/preempt: fix duplicate extern declarations
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026, at 01:14, Safocl Stollmannovic wrote:
> Compiling a kernel module with a C++ compiler results in a duplicate
> echo =E2=80=98extern=E2=80=99 specifier error.
> This occurs because the code contains , and
> expands to  when processed by a C++ compiler.
> The  specifier must be removed.
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222257

The changelog text makes no sense. We don't support building the
kernel with C++ and this is not a user-visible header.

Leaving out the 'extern' in declarations is just a preference
in coding style, no need to send patches for that.

     Arnd

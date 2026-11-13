Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573428;
	b=3KBLbEYsc59lEE5SRxX/4nC0uwneYWoIHakrgXAQmip44JYKVgDYGI9kN9TCn9jPTode
	 G7++zJQRyX4c37sEa9l6Ns40f2jNk6JdZDpuGzFf5Vge6EP0/75YXl7hmQlDIVwWtnu+H
	 pzeX4Cr62aqB5hbjH/uOjusTQCpTLtifVgaqcGiLY5bdtw3oxpZ/nWcx5WDVnwASjRC5T
	 a3KswxeVtNmGZn2Gr0DmHJA+djRCgjIXpu/ZWYuyjOu4hwmyqNjyxLybvk3EZV9nbyQeg
	 UuA95OJuFcbVCjS0LzKFYWoBiTl9dj+2NoiE9aUCZQ/x/FHhNTr4Rw5VkEiAmR+s6ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573428;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=z40Vm2fAMqFkLaXILBWuX8s1kk+BJA3BdztALF+K3R8=;
	b=PlUCPPoQVX7UlFvbFwM4jLysZu18/EBtqwdmC4QEatpdOs5UZC6Nuo+lzvg4ESSZn836
	 mNSVc2jITmQob2Zscid8M9fqS1tinZeKz0BJ+wmb5jt8pTxRDO8V9aH3jQ+xapKH1K+GN
	 eYDLjMMhxrOoCatfcpmGLJWpbPv7BPwROjhG0qJC9oT/5HTVqDARxu1ehDQDvkvrEL2zN
	 Di0jgBCZjxZTTR6jOAWji/UrfupNwdERfdHhBAusavLDWUNNwEU0uVUB2hfaHXJWeHDxr
	 mGPz6WMcm4pfjPETL4YRO6xo8JzF4d8hQf6JRlXwU656RotbNXqfyKxfaX2cZFvWP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=hmSnWucK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xDzRO+Sj;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C46606A8B1
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 12:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C46606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=hmSnWucK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xDzRO+Sj
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D48AEC010E
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 07:37:06 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 13 Nov 2026 07:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794573425;
	 x=1794659825; bh=z40Vm2fAMqFkLaXILBWuX8s1kk+BJA3BdztALF+K3R8=; b=
	hmSnWucKtdc3h+9RiXLJP4Qd7hKHwhcrqGaW+TttDkwmv75Apr0qL3/XryginjIw
	hirCKIdLYVnxZMyWIogiuj805V8dlKc7h/PdB8scMOhHlBOPCvVIhvMGuvAgvnIf
	ENb/ULGymsIO0jb3wufDdDeBRUYh1Ohk+lyXxaVnX0Eb1pq4m9vxu06o6FiBwCol
	CLnqqmxxFvMhIpacTl53IbOZ3XgCvNCYI8XvOciSY9dO0Rfxc9EnYrbx0BY8rv9g
	ui+WqVxtuWPMM5tL764Bpf79lkt/PbalTNP/xIOB3p5fp+CNI+5181qsvMGCizt7
	GjO/jaLGL2sMSQPDEJCRQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794573425; x=
	1794659825; bh=z40Vm2fAMqFkLaXILBWuX8s1kk+BJA3BdztALF+K3R8=; b=x
	DzRO+SjP/hdUwjeGu2qOarRr8ot60XK2ZUKgqJ4L/6O7je/70ijxqijjF9/lWUpk
	ZLlSWDpIn+rVLZVnq6yBZXiits2vX7ctIowgdxW835mrB+jtPVd3f0Z4ZpMWCz14
	+Nux8BnCFjCWl5su4mCt8WzNk27CLG4w12wS3dgM3ECEXFIB4c06avxTx5oHBmDq
	hKlfOTnp+d7EOmrrP/SA2AAgOIILE5OjEbHY85/qNwqNBq4/gOabCGTrJbSXPYiw
	Do/pggCt0N9auICjKETTDzWHT3+Xb0EUqGafX4f2zWIvd8k/GLDwZXw6XMNq5NL1
	I7a13LiY80ONQnip3sVkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794573425; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:im7hyo3bNoWLcXTGTRAO9B22Lf3EXNwtUHSbnP5dYPYrcXS
	1OxE0xMbuYHeGbpsDzcwuxSw6w8xsSandlpcD6Htw93656JSgNRkzt8BDCyuBOOj
	fTkTukk85FbEeQg8HzXjdeIlpVgOPkRzDrz+kSs1gTfu4aG90CgnmVoeT2Zjftv1
	HNIqjiJWVNWqhjUAM0y3o3dHhXJXPVa7VL9xrTz6wmzY4pF7Jke0xMQHtp+Hjg3+
	r2TFy5upmlNNw5imf9YfhSHO/ZfFBCruS/jwE11W/NrbMkF0PkhnaiVFWFetegvC
	uREZ+gvEDe0GfjQ7uAzNtT+5JXGhFmgKwpJBF3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qHQy/nM/Qm9jKypAEYjfqJ3dbgNRE/HClWSfCIlRcaw=:hfk6n+1L2C8rbPhsEkMc1RJDHh9xdb4lEkUlx9Xc3tY=;
X-ME-Sender: <xms:bwT3ao5cKvkqkdhOILQRvfIynVpZhBXHJuV6r-yM4S7tH5H3Saoewg>
    <xme:bwT3akvQp3gWTopQra1ObD2v53_R5Q6RAEhX-Ul84J8QvD--mtrKwY36VbGnQTeNO
    5EjwErJtm7c3wvt4VFyxlzSHhqEdKNXiVHcTTq366sQ7pO3_MRB3KaB>
X-ME-Proxy-Cause: dmFkZTGzwUY8EsonYvqp2kEGFjTaYKdIwdCC38DhSR3mPB8++dr92GlWAyPCfu/DcMvijr
    ye1O6rYw1iIFQ9RK8gg81WNP7mhc42zLoOuE5+4buPDqXBQwscQlaJ42i4QKREq6SQAf+6
    2aBD5eRQ1GwLXWC2Kweu/srbGKig0CWtcTkV2Xh6r8Vvj5NTGDUjBF2cGuxUdXtNvItKcn
    CwDtCZybR9s1U0/b6613Z/rhbcGYRm/NxIKJbkVsbN8KmjQHu+E17BMziYiiNfjfDYnfQd
    nI/Yal/r2Ue9h7bbXWxWaYkHyfEa42qIm/N/LeMLWCiZyz/3Pvu2NqQQGoARmdfE74IOFt
    pnetGza4YuovoMJolzEcWoNXS/udbghBzHimKG8o6Ca6fIPeNpM+68zrMBuA5+jkisqtWa
    4pyW2A5QaACgCy7iP973xbDatY9Ab/si7x9zgo4OxiQqo66yS2HoY869ACws+Mf7zlqIB0
    zYfJxXAYUb9OhUKT12FCWv8l0ONGSMPgCQQsQmo0vdxHifn0A7Rabs43hHrFo90x+xIqtF
    NK9mVkl9a98j9kB6f08go2RiQGIPEhFVJzcVZjm62fMJcxBMxK7ESAo/bmrNSTXlzDZKPi
    zS7m4c4V+/w1/fzXEJFjatawzyswG5avJ2Bv/a/UK/HtWM5Ft6Iobpws5JGw
X-ME-Proxy: <xmx:cAT3aufuP_OwX_9BvuHlpWVzbE66AdQWa0TTjY2x0LpanjGtsNwOTg>
    <xmx:cAT3aoXDYZxwsX18di9_FGGvRNn8pjcBpsvef497YvnJsQa8I7zoDA>
    <xmx:cAT3anfHuG0Lqt-JVhl5feOlDq-NrTfXiCYiqdTIrzkY4eh9H1u0Ew>
    <xmx:cAT3akOYxDFu6Lzuq6lMgB4PE_lZRNzKiKpAUy_2A83X05s_6LCu1A>
    <xmx:cQT3anRaKq62IHgZ3sdelS4vFTzVW4zXzb1lI9XJXKAp5N5xaA1hiE7L>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CCA9E32A009C; Fri, 13 Nov 2026 07:37:03 -0500 (EST)
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
X-ThreadId: AKB7tTMcLza3
Date: Fri, 13 Nov 2026 13:36:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Safocl Stollmannovic" <safocl88@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <410bdfd1-8b93-45da-89ca-48d8448e19fd@app.fastmail.com>
In-Reply-To: 
 <CAJtzy8Lj3pZLZUha=5SS4QfLJ-_NzX_BiVM=JS-xAx3XEejVVw@mail.gmail.com>
References: 
 <CAJtzy8Lj3pZLZUha=5SS4QfLJ-_NzX_BiVM=JS-xAx3XEejVVw@mail.gmail.com>
Subject: Re: [PATCH 09/10] sched/preempt: fix duplicate extern declarations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 13, 2026, at 13:02, Safocl wrote:
> but it contains `asmlinkage`, which includes `extern "C"` when
> `__cplusplus` is defined...

That dates back to the (failed) 1993 experiment with having C++ in
the kernel, and before the split of the uapi headers.

     Arnd

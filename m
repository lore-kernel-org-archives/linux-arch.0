Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E14343F3;
	Fri, 10 Jul 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699239; cv=none; b=psOJmlRN9BFc/zCXV9pns2X9K+VAEyk8BgVuE4b/czjNXOEHE4gPwGk8O4JSUJBYWUOq6SyN/p6kcjM42vCpgIDbViwIDAZ348BFxZJp6d7tgzmwe6cHjNUffOwKm0adnhh9SnIsXGp/u/aZYR+KTJYuAzn3nG1R00KoOjF8XuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699239; c=relaxed/simple;
	bh=dyTGQVpE/XQ20CTj5yKU56GOe+OIRXiPo1pB4wIkTso=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EamiOPrWtPhRw1BowqudDr7MKWUXr5vWZsXvvRuCWfgjprVdh59X6opn3BtkA9NFoHjqBWQsd2AwIbnmag3WbgH+rqC1Jtr5EHLN24Qd+JQAClhYixZcbsTznVjrdqiBQwyiycrgC90xtnfecgvE55tmpT/tmjBdNoY2yg83oxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PGXC25HU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNLBbcLx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PGXC25HU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNLBbcLx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D7C01400108;
	Fri, 10 Jul 2026 12:00:31 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jul 2026 12:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783699231;
	 x=1783785631; bh=xh+sDsHpazFTFZx3vfrQLYzWsd6rDYC53w1yN+flPQc=; b=
	PGXC25HUeUXAcKz/qiHkmChzH1MVOWeYGouVzm/oPp6aGEKRgwEuwgc9ggBcXo/a
	MHa7n0Ka5JfNwVEs9dLzz2fO/DeUpC2ik4dDp5G63cT+C6hoLHwHGUPfCYLxRUDj
	fIewVPCOxrt8I7LKDBZKuDeYQdp2E8tgIxYPx6amobDunhsfxhUMquC3/moTDDYG
	Ds1PBrvobhLG6nE01Bw4W99NpJAhmIcvfiptf8RmiQR81gELlrepXx+7nt7P9NQy
	o6HJMB1uESObxa6k1CgZd1McWyLzhjwvsFBOQJmupXeuWze7ZI3KmNpgKgknxpjh
	lA7f4n73uqsBUGsbB6k4KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783699231; x=
	1783785631; bh=xh+sDsHpazFTFZx3vfrQLYzWsd6rDYC53w1yN+flPQc=; b=X
	NLBbcLx+dqAFyjxgTsIJXUREGwrBA5z3qlTZPQQsThv99A9v1exgNldv/S96GgzK
	I2NLdmfILaIc1mL39di2p6XaWzOMNiVssQYD2tB8L1zCfAbMX3M1UwNZv/23jApP
	Z2KUJvprxTi7JV7iJiJdidE8gxKxgGPuF1ZrnlzLU4InZWwcuOero4xdsNlsZTQR
	2U4Hd988RnGABNZhOEyXJ16+BQmqH+cHioMEb9W0osD7Roj/8McjHCYD+K4J4tA6
	qAOgDEHNGJwM2BM7A1bnrAIIBgG4dWtZXdvDk4DB1Sn04ZSifcT6ypwSKrNy70We
	5T/BafO90sZ32PpMZSLTg==
X-ME-Sender: <xms:HhdRaqIT0_JqhmSC8nMtSXDUZKdKw0gBvx7ukOSUGS0HBIoq0nkDyg>
    <xme:HhdRas-7aXh8mII-V1zHB7rRzPu9BGHa7xuwaU2ZG5ttlYRewYf07tvxitJspsi-q
    bWZl8SkfDiukgZ_JbP0m6Hp0yT4Z4maCGb6nFuPwUez5rRfqO4ptW6i>
X-ME-Proxy-Cause: dmFkZTF/D7XEemVIzhqh+MvGbobD9yHt/GHpuib2UI/WeTSduHiFLfsOdDu67+Vs7J1+x9
    OQPv9XejemVdWAhKn2RvlCAuIZ6CviPDNJzUmXYsF3o//DFt1MaDxhlSbg3LzNaJZ++R/c
    fqKsXefeIqA22pR6Ofzhrkb+JE+frVMVnyuvG65qD6L44jpjYzVI1pyGz7lhtbS5qXzH9L
    egPGMVio56eleQ6ANbxZfdW0xvNM+dUwTRBrmVIUec+AbynVrm2wowhJnA4mRoUcL2TMmQ
    mqf88FHGYokfZp14VthIdwzvJ/TE1FmGecxWWblFjg2IpLV8Gmwro6wKPqEjmcVO1lWwWZ
    IqacxR6nex3bAkBr+hbdAi29TWcdtWkFPNZFXyZuKcKudhr5XMiy1iyLjSLLsiavYKt43P
    5wna7zHq8espFbQhYkGxB4jcFDExoDpk0SWsRXc24AwQktkSpr8ZdAjHKC+uxVAz745JrW
    lx3LKYCv3/9ABf33dI54aOZqlugobCis2o214E7m+JdRyyxNkUAi3tjf5Ju3c0vQT8VsOS
    CWrGfZKLFFArp7DNokIe2K5Mwdgiu+iPDgAOAKz5tNCYVzpIXuPxxmldOFKzYtMrQPGgK/
    HHy2sKeuM8ofVXlwuQ2VD84iwUzqGbA03ygB3LBmJxFT0DO9H8g5nb8UZqsg
X-ME-Proxy: <xmx:HhdRausLaDPY9U68EWlmLhpHsYW-kT-dwS54wF_IG_4kxAfW-UId-g>
    <xmx:HhdRasPQzsF3SIaWMVlb_HvUnY9xrWfqIEJkVi0iVO5y6GFjDspNJw>
    <xmx:HhdRaoc0AS3smy7wAnaN6lA7VrUWG4jTt5vIPFRZHgHDLZSSwJaPXg>
    <xmx:HhdRark-Qx9AnLvtcRqeI_REz_mc0JKyAKBFIUxzwSxfQhor-vx7aQ>
    <xmx:HxdRauUHZAp3l_FMvob9KsRom9miHUxu7OTLqqKfAVKTU-0XG3OhJHK2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3BAA31820086; Fri, 10 Jul 2026 12:00:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2UGMrT-rt8g
Date: Fri, 10 Jul 2026 17:59:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aaron Tomlin" <atomlin@atomlin.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 da.gomez@kernel.org, "Sami Tolvanen" <samitolvanen@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, neelx@suse.com,
 da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co,
 mproche@mail.com, nick.lane@mail.com,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
In-Reply-To: <20260708020007.55728-1-atomlin@atomlin.com>
References: <20260708020007.55728-1-atomlin@atomlin.com>
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in modules
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2026, at 04:00, Aaron Tomlin wrote:
> Currently, the "module_blacklist=" command-line parameter only applies
> to loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch extends the blacklisting functionality to built-in
> modules by intercepting their initialisation routines during early boot.

Andrew already asked you to provide more background on what you need
this part for. Do you have a specific driver you need to disable?

Can't you do the same thing using initcall_blacklist?

> To preserve the existing user-space ABI, "module_blacklist=" is kept
> as a legacy alias pointing to the same module_denylist variable.

It looks like the denylist is only introduced in the same patch?

That sounds more useful, but would better be done in a separate
change, and also needs a proper changelog text.

     Arnd

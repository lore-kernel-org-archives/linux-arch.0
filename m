Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7F5A0AA7;
	Fri, 11 Sep 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157868; cv=none; b=WhTe9cJKdkB5OsL42XIlseJXNg8CWuwaWZRrMCiSkOl7lRdOKiSrWpV0ApvVcSos61i8tRRu4XvSXFhRTJbp5xr4m/bIC+SSz792rrsiKf5LDGXdBrZ0JKASagHpMicv814SDiNF6JNGllVytDDTmt2+nB+HX0vz+S03HJwxkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157868; c=relaxed/simple;
	bh=2fDN+ZmP/560wAFG8cOYJtqKuHH7Q8sHCodliC/q8NA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ieGYf6SmxiGsdkGqmb3uYAoDOayQ0tXFnuddecEOxxsyZOkHuHRtpI3BZzoGwcb8nHLGjnTNjzF4ugkXC/rg5rDw/agfD20M1Okin4Odkd5D+Ehzxn1fR3n28lTjSMtfxLSfJZ+lu06aojR6NASKn0BLEmLcI7PV+tXKBecVooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Wu7myXEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wfxl++9N; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Wu7myXEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wfxl++9N"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53CA57A00C6;
	Fri, 11 Sep 2026 16:17:43 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 11 Sep 2026 16:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789157862;
	 x=1789244262; bh=6EbnYxGqe0xixbnmgwrnZwLddp9Ao1JEq2A2JzywCcI=; b=
	Wu7myXEuTU4nZbcOAv+QPnbuAtWv8/+K/zriRJrhRxjnzdYRc2AU7kih4tjN7u4x
	FPsmMYEUWPKmpkcz4FTBjjna/GZEu6Nru1MDgU/VVsvv3wkFIfiiLgrOlm5athXV
	EpLnTenvHSogbwrLX5VrFXKiUXCht2PmwLZZLGYIbi3lnq+TzGADNgyzdTR6vFpz
	vlTbWSud0X+E7Twqix/O2qWfs1WhxAbh7Kq3Q5xN1tM2zkW6O4QX0gM1O+FT8hoB
	6gqZyDW4m4hLgylpWza7RRsgJflSKPybgiWSft13eFyuR2TQCis0g56wedFzPDyh
	09uP9TuOXOGPVBUdOyPXBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789157862; x=
	1789244262; bh=6EbnYxGqe0xixbnmgwrnZwLddp9Ao1JEq2A2JzywCcI=; b=W
	fxl++9NU0d8tHTjJWeMiF05jlpLzcp5E3OeAHqL/90wDxsS+Vhgpg3kIsI9Bu3EU
	XL09lXtwZ+TWYQAdTdDPNoAelXZjVG5JszCpgnKrNwfkBR3mx8e4RAfVxJMB4C42
	8Prv6vqIIhByMUEZIjDYld26i7/H/cUexctkJsp/WgiVDoMn/NUt2Gd5j8/bZr2Q
	BsJhHiK7aak41f7vAr3VSyVeboF41dMBB0gZOK891Uswa7Os9v1gMNh3GFtdylxl
	n+EgKweNNNW+0DYXIwbBr6QpesBHrdh8SzVAwsgdWlTMYXsSnE4tjIUo0H4F+EJZ
	G/0U49j1q5y/trkLHXvhQ==
X-ME-Sender: <xms:32GkasISX4WbD9wG2rxBdBe9Na4bcX9xm_JDGLFHnSAeHgzRE7Cr3g>
    <xme:32Gkam8cvJaPKT-InblbjyT5ZdW3r4rROkjQqvt8SwiQcNb90L0c13Ez9e1WWDZYt
    o8zuYY1S1ZV1Ph152Mjx68Bl1uPhuNaKoSyMdkdovZZRP6W8uTGFgo>
X-ME-Proxy-Cause: dmFkZTGh0gLZNZBxe6Y5EwujO7h5YSAbLaol936kXjDbPkBTmCLtncegw+FJypwAB0cXMF
    5VBA6L86GAs34nb9D7LOw6xcYkzdt4dfxfwMc8Df5DPPw0PSZiraAEsYITNStpuvxYvP85
    6dvdSeWKu8M2XUSW2E+8odMexOEm7bEeGAV1bLv6IUDtMPL42JsG7nVzKQ3TCK37XXCqpF
    92nRhGgzUy7iM+hCgmBshWzd5f6IuAsIj1DYDhgRWpdZJnswQNoYDbW0rpqX/Jrupgz+Ox
    oX9VL28TkUhg+2x+ivO5QRzZ/lXB/ma/Oe2TQkZPd7YTZf0gQEzke7B2TrNvpS8cf5e7dW
    YRtQzOcaJqvDbyTDiI/oDLnR6om5i0xGnn+PB0k/ganOZxbe0EHjVJz18oZTNUAD0EE8km
    qZf/fwV/9PWYrKrL7rpucLFdTIAGYZkafGJloWzOICo1mjJY1zl1AAfpAX5gvKvkt96MCe
    0g6F6eYAV2zE9g7/JOD0zhd41ta7wMu40/Y1hfJ/ksIarblZHeIFSeF73Fqru5qQzxQ9Yz
    biMdM4KTC/yRDvAI9oPHDbpFetrxTvBTseI+nPrLrcgxdSAOAIkK2JJWNR/MoL23csKjlL
    RFJJ1UuW2r5iPkr1kmh8qX6hejxePJJHDk8MSoQlBO74jfJQy3+CfQtAjkAQ
X-ME-Proxy: <xmx:42GkaqkWLW_2vJQHOwEHI3pQ7h_Ufp9XzEukJ1yf7GqRnnR9rf2R2w>
    <xmx:42Gkas2MNrwkQq_g4iUQMQl8VCOd2jaIkEptHlnfzmC8IFqtis4bMg>
    <xmx:42GkavRzfofbrj818MWgcK61z7kwSf12vFAwP0UXtZXA5hPaqKEUcw>
    <xmx:42GkasOoPcljqFc03VdUTftLcTXe_oRivwx_b_Y3omoLYCYky55G9g>
    <xmx:5mGkaqQwkNj47I5B8l0Garx2qvsPVJE3iphHAgJ8dCMedEAhlmY2b5NE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C7F7532A0081; Fri, 11 Sep 2026 16:17:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Atvpn89t2M6-
Date: Fri, 11 Sep 2026 22:17:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bradley Morgan" <brads@mainlining.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Frederic Weisbecker" <frederic@kernel.org>, neeraj.upadhyay@kernel.org,
 "Boqun Feng" <boqun@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 rcu <rcu@vger.kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, "Vineet Gupta" <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org, "Russell King" <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "Chris Zankel" <chris@zankel.net>,
 "Max Filippov" <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Message-Id: <a817a6ed-7345-435c-97bd-a394b90e8366@app.fastmail.com>
In-Reply-To: <20260911192540.20983-1-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
Subject: Re: [PATCH 0/6] Add two-byte cmpxchg emulation and wire it into the
 architectures
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2026, at 21:25, Bradley Morgan wrote:
> Per Paul's note, Arnd Bergmann's platform removal series was
> checked before analyzing the users. It removes the imx31 and
> omap24xx CPU_ARM1136R0 selectors, but INTEGRATOR_CM1136JFS still
> selects CPU_ARM1136R0 until its scheduled removal in early 2027,
> so the ARMv6 path in patch 3 is still live.

I can still restructure this and pull the INTEGRATOR_CM1136JFS
removal a little earlier. At the moment, this is part of the
patch to remove CPU_ARM1136R0, which I had planned to submit
once the arch/arm/mach-*/ platform removal patches are done:

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=a8cfcc5533e33a

I could turn the mach-versatile/Kconfig change into a separate
(trivial) patch and add it to the platform series to avoid
churn here. The armv6 cmpxchg() code would still exist
in 7.4 then, but be unreachable.

       Arnd

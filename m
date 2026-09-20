Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E43E075F;
	Sun, 20 Sep 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891940; cv=none; b=UbC1LVXmu6ZrcumsrHwq10qZTHGSwM9BIm9IT+VwoZCMFLVi3eMpQfBMm7su0ZV5q9jstUuNAH9opBNGIpUQbvdI7maJutaNNMGzavzbVmMf91hUT613lq2EavU9Zlw18LhjKHThDa5XMZKu3KTC+bV5h4JjgdnKqT6GoqSRbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891940; c=relaxed/simple;
	bh=NGViRnHEvb52kMCFj826VF6nwULNdsjxmXj2wyyY7JI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LB6iqwhe2dn1+Jrh6nG9ScO9cFtnO8nWPQ9eEwBsl0mu2gpPbuJ1Nz5+xsisdR1wyahtmy14s3VDF7ujvSgbTbCmPz+Tm3j2nu96kzmGtsjHHQDoF5lTBjDiL2ro6dsu+GWtvIK5TpWt0N184aVNWHWziCw0zWS5sZW3cbP7O64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FtAHhuKk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZO+Pogga; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FtAHhuKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZO+Pogga"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 527631D0012E;
	Sun, 20 Sep 2026 04:12:17 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789891936;
	 x=1789978336; bh=LL0qgdhe5vMli4ptR7yDXLlZt6LsRjcxPU9ZpdkI4tY=; b=
	FtAHhuKkKD6pDSefWJO4tHTdBArv0xim5+676BjUce4LvzFdT5k/f7nstJjLUsZ5
	eSBJPIev4J7TBUcoZEV/XGNzYic6HKaA2aBis1hpZ90c0fVNsxafC8X81WycxVKu
	/Iym0Fm/aauYgBPiW/4AlLfuk68VdtXK7/Wog+qPE3Q+v3LjChz2TStuUOPKs+z7
	hdzUiZvrnik+vXXv2HUGIH5bU7JwcWDnCNgmLaPKDwzQEKyol/LpvpEDh7f/R6+t
	KLONaCRR3ESO0MiEFawvF//WQBKnIlNoKzRQzATsMsCcNO8OsfMy9RLcfvoGRH6p
	r7n467geiOHO523RvsT2wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789891936; x=
	1789978336; bh=LL0qgdhe5vMli4ptR7yDXLlZt6LsRjcxPU9ZpdkI4tY=; b=Z
	O+Poggah/fEUxEU4aRi0ONVwbbCKSi5PVXtSuLbq3yyQCAanFHs0qibrGxBav+k7
	fxp1wBYc8m/GPVnf4ECUosBmCnqvVK4OBGo8ZO5k/Fs3Tvy2Fp5hFRcoNjp71x47
	oupk9gM8pnyrCfKyeeXKN7XrsWTO0uPn9cplMdALXCq5ZNs9AUSu7bWeKv5uaCRD
	vGGoyXLp1V7uDlJTg5h8cJt9AC76rb4b4EtsaYwyvCL66e0EAu7y7OUEMeEN00Nt
	61heDzwdqn/xbQ6m8ng6Rk0HyN2lRLOl6tP+ahVX+O6sqk72r5ykW/AnL58dCU12
	uOHezZMEcGwVff3cnXMlw==
X-ME-Sender: <xms:W5WvapPVlHW0Nuup3YRwo8Qwe7ZY9qDua4cbRbN0lsAgC_-F2FUkqw>
    <xme:W5WvamzVUwFiu_6pEdson3otpxfMOB4cdVXcKyH7iPHh8efNyuJqPoWvH3gAYNd03
    NsigueRs_Is0CrRQU2IoGsS7V3c8HCIkYszfq7uoFneX_X0FYr3cfpq>
X-ME-Proxy-Cause: dmFkZTGxVM+jdyBPEbuqysgbv4V1AYSc2Ze3wGifSpw4Bgx+yDL+YsLjJyo54AiVexC+Jn
    cAZOxxbUj0gMMffbfvzLpGQrcLPne6J/xe7bch/w87sNfnn6sjUZipbZ4XfdaeZfvhc7aM
    Qv1T2YbIfc73E9yd/7OAEjQUkBRT8qdLx8KXUQ+gss0vgKZWXNh8vXiHjagcKaIP2NEYor
    sJfJVExLI++2Q/lRT61A8KYIIadCly5t9z6juvwWY+R+S9tIW4uOyUWPLQokeEogfCJPd7
    n0eItv1KTsc6PPupwxDUztEjYgvO7WZcbVx3sAbDgrZ3HfrHfpt60CLaLEm68EtqxnvPm4
    614ZEg+wXd8oxD455/wMbNBLo/usdmmF9q7LNLS3PsTXtvWp4imfPo4zMz5qXFcebaLOs3
    TDsqXVBmfLKkPA6PYZeFMFoVs72ck16Z+8II/CYpGUGJd8NgaRdam66diGb3vtqNd5dc0g
    6q3RFUexz1ZaSTF3MsR8M58d/rTe04PENI24ijrx82CIuWPykWu+/1UuH0TOEuKeDFOvb4
    z6tvRw+SLdNZ9mzizDYzw0Hd8bfJWfUVX+Zv3zro3OAVFi2IRETTpKyG++Z3bR8gROxzZ8
    RDHwX7iWuN8F2CwdwAAOyIj8xpEqkR7Q3qhI9IieOWBWQ7hi0+uBx30Sm7gg
X-ME-Proxy: <xmx:XZWvauobGgoU8dBFQ7NzmlfXDgWf1utncw19YTEps6knhDIooSkUsg>
    <xmx:XZWvahnUdnf2oCx_-caLB9mevZMgbyE8lW_pMkQvtxl3yAxGMbWT8Q>
    <xmx:XZWvanf0slZD8F8D1OQQl9O89iw6gmPwM-pX2kJMfusxQfM-GhDlzw>
    <xmx:XZWvatq2KlPZHyOMaNGCB2CTK-5OgcEyQYCySvolx4C9pnrPFIvuVg>
    <xmx:YJWvaqWAICrOjGX-MOvkyhg6qkQVrKEvNKQYnQfOcgw0DYRNmmp_0W_V>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6923732A0087; Sun, 20 Sep 2026 04:12:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzgOxjlYMeWB
Date: Sun, 20 Sep 2026 10:11:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <eda11c76-681a-49c8-be6f-7d2b67f9ab81@app.fastmail.com>
In-Reply-To: <20260920014357.7069-2-qingfang.deng@linux.dev>
References: <20260920014357.7069-1-qingfang.deng@linux.dev>
 <20260920014357.7069-2-qingfang.deng@linux.dev>
Subject: Re: [PATCH v2 2/3] riscv: use generic MMIO accessors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 20, 2026, at 03:43, Qingfang Deng wrote:
> RISC-V implements its raw MMIO loads and stores in inline assembly and
> duplicates the generic ordered and relaxed accessors.
>
> Use asm-generic/mmio.h for these accessors and retain the RISC-V barrier
> hooks. This preserves the ordering and MMIOWB tracking while allowing
> the compiler to emit the native-width loads and stores.
>
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Your changelog does not explain why change it. Using inline asm is
definitely the preferred way to defined the __raw_* helpers, so it
would be better not to change that aspect, same as for the arm64
patch.

The other simplifications look good to me, those are the bits we
definitely want to have common between architectures as much as
possible.

      Arnd

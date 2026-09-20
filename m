Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027F3E1713;
	Sun, 20 Sep 2026 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892061; cv=none; b=tiiAcMaTZFFJkiw5muxxSxrRlshYsXsuVzg1B0VBLsgzoA6j9sOZSfiaMu6HSEJVfjPmzDNLYrKEE9fO0qNHLZQYyhl/KRr8fUtJwnSANzhsBrmx7ZJf1nJZOp8Jyz6PFtLd/LbwXg+O8TW9uT4nsXrdTLec43BEiDSnLnGvu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892061; c=relaxed/simple;
	bh=YB7TWC2xM7ZqURBX81QU5kFqs84+grPVL8jCqEFre8A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D/QDZ3xt+WL+UKhF7gtc/Anx4GPqjS0XVjPNVUA8spUKUpFPW4xbH5iGvnBsZ+TYgPw88IGT84UNWkQbSTEg5cocGhJRJQMi7Lzrt4P+iL1vJxaeNcb45hlzjP/7SSByfsEB8y9IBtu1ijkOt2BhRQs/eCcepGF8EmxKF9L0/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HE0DKssc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYSUFp/g; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HE0DKssc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYSUFp/g"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 17C901D0012E;
	Sun, 20 Sep 2026 04:14:18 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789892058;
	 x=1789978458; bh=EPmyOgHof+nHvhtew73hbrVSdx0x5IuaAJ/o/OGrfBw=; b=
	HE0DKssc7RfTcXWhFLgFK1o1kE9hW+srqrvBAqIA7Vbk6VkOeH4b7ceZTkALJk9C
	HuclxuMhmC95PaULbXQxs+IrnjPWJqMuyd7rnjhf4Q8GGpHlpBtN9lc2PORrl22F
	S3rLwyIIkk2bKO7deLh0XY/GlpQoX93ZSkTtJ/dXGW98BEFsLK0fA4bYU68+jEgL
	VubW0yO45ZOZxJskamw+i54Mk0imO2dykoQW+5G4tXNgYPWVMjzrm3NLZHwCganT
	Nmx2Hkhza2pvij1emrV3JUTiZz5OIJ8YRPrZu6XLltwHDcWbnSFERjuF8Qmofh2M
	8tO9XxbtnmLGUpISvWQwtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789892058; x=1789978458; bh=E
	PmyOgHof+nHvhtew73hbrVSdx0x5IuaAJ/o/OGrfBw=; b=KYSUFp/glgT/GYC2X
	5KmuGn9sEOZ72Hi5A/yT7649/mRs0hH/KgUtJG1DoRVuf4yHwdAXEAuygiVf0KGb
	xJPHmZR/3IODcwkA38upEEcGTqB31RShXI70FwXy6n+e1+LS8B4/BzokQvLqjB0G
	QjpqwBM2pLBe//Cl9ptV+k8i6FUrDhe8lIxvhZVbHZLC1Pg5h/cHBt4CgIImkPeN
	okD/b9LqoCcZiP8Jygr02QrI95Z5v3xibFBoT0YSoBHSvjBZAirw1XyOrk675WxD
	Xct6rsuI1eIlfFfGq8JIbaCvEPspWMQt7G9k9E0WzDcw4nstXVFfYraG/0ANXyFO
	+Myvg==
X-ME-Sender: <xms:2JWvan3yg4eILSXxU_1iH_hRYb_HsV85ff48eBjmON-II1qIQ_JaQw>
    <xme:2JWvag5h1Quv5N4bRkJZ63RyjtJWLdOu1hQ-vHnw5BqhnHGCrSGIPnT5BN3s90cIT
    cnu_fQIWRMb5SBzibaZXPsjnX7_MCe6P3MIrKBSPes779Z-aKnrCGwO>
X-ME-Proxy-Cause: dmFkZTGVudryg51ynvvTyQNwjExgVJHGbfZwsyhfYkuiOCU5FkfZhWViKwPhNUJ4QV5w9c
    9Z0djytStxtIs02dEvySRaTXGfmJ4WOn+efcO+sV708bL2EEX6fsY7nH/aG5+F1SEmKlXj
    A1iPlXafu7TAoNUTzeAnvp5PqQ4JIqJjMdyhzOxVoCAVwBLMdvkldtFxDRRV8AzxNtDUSq
    wCO3OMspIKqkoa/x0cBGEYOGjAz2xEQvXX/IXjzRBnOvcFV8Gy4xaL7ge64n8mZJcXT81i
    TBlVM8XEtYYhUo98PnEy/YW9EEMRO+8kM2cG33TJL1MyZll7qD8YVVzYZh9tqGOQM6Q8JI
    i/5OavTeVpveLRX1X4ZWwuwDKgQJ54SPqqsoh/U5HirCjleLpLNfI0qUAkOcwtHxdKqfda
    UlHfVn7cKOrmkDUypVsRvwfumGQD9aDE4lRk6bEo4d3NcdrGEheuX5Mo9ylGvezLp2q5/o
    Ub3UlrfHJsIBesG6we3Bqmhz+bFmcWyLOpLiMPcVWJt3M1ONvs67srWoNb9yEsaAcOEgI8
    74Lpq3k9fDuWCsFqMYnFB5ylv1/4fFhz7RepJ5pNNww3N7fr969HBxUIS5P215GWudsdlY
    1WMgjoCDpGzghJn9g6hWNb3kIi2MYZam/puuNr/UXqb7BntpGd3OsZJhFglA
X-ME-Proxy: <xmx:2ZWvanaFfdajwNAJFvFxTnkqr77KOOYMrwHzU-NwDqUxdPm-FsK5Iw>
    <xmx:2ZWvamhYs4AR0elpOhBD2qCzOGeGPzQ4XCVNVUL9VWgDrzTGgoj1mQ>
    <xmx:2ZWvah4efQueDiSM8KJPTazOw1H16FbgAsVw5LlgBpyHveuFf5PR9w>
    <xmx:2ZWval6HK3jtJIpJi4LsuX2EK-lu1j_PcB8aVrgLMsvNBxwOQcYtXw>
    <xmx:2pWvaiV0bKLGFRxIxEqJ7n6zwyY0lbG7gMyMZ3dT3EVE90nCXO0lVl78>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D09C232A0087; Sun, 20 Sep 2026 04:14:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqpJ5YLm2Z7J
Date: Sun, 20 Sep 2026 10:13:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qingfang Deng" <qingfang.deng@linux.dev>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <839e8422-6414-43a5-a086-d9118c6c2902@app.fastmail.com>
In-Reply-To: <20260920014357.7069-1-qingfang.deng@linux.dev>
References: <20260920014357.7069-1-qingfang.deng@linux.dev>
Subject: Re: [PATCH v2 1/3] asm-generic: split MMIO accessors out of io.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 20, 2026, at 03:43, Qingfang Deng wrote:
> Low-level architecture headers can need MMIO accessors without the page
> and I/O mapping dependencies pulled in by asm-generic/io.h. RISC-V keeps
> a separate MMIO header for this reason, including for M-mode timer reads.
>
> Move the raw, ordered and relaxed scalar accessors, their barrier hooks
> and MMIO tracing support into asm-generic/mmio.h. Include the new header
> from asm-generic/io.h and provide the byte-order and MMIOWB dependencies
> needed when it is included directly.
>
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

I have no objection to this, but I am not yet following the explanation
regarding how this change helps. From what I can tell, the changes
in patch 2 should work equally well without this.

     Arnd

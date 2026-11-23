Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421401;
	b=S2UD7vu0KWrgNYy39tK0ONuTWNZSi05q8F75QPhSCrE99JbGBoWoa1D936G8yvrYOzxL
	 JI9Mg91N7SWq4k+BABoOLpR16G3QfnKIRLh4AcjbLqs2QzqciE3DCmrUkk3DqJ7RB+fVI
	 5UhzEl45Xpxz8hUSraGQbDRl1hCs46+0k4g7g76LFrEhwpriAWms1GRFIsOOxS1f3jsCN
	 r56Ol17+3aeOwIi0jPkOjjOjrZL5aw1b+QTDULDFBRkEgH01cJVhcEcXAMuK+5cbXBe9v
	 bw7W9S4npEHXJ97tbeT9u3LUA636DXaahXnXPwZ5ePfW4FwuZihKtGm7xvBm3RoKV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421401;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=DXAyCJHoqpd7VVu9zCdoKyDE7YEOeTBsqV4rhJ4wDfA=;
	b=anVw+xtWclG7E8opr+vO3xyz8jGlzJW7dkbvf/iqHF3SXiN6YKWfhLWmq6gMhXAkcZoF
	 Pb5sonCO+Nd1btqfgcy7r/NWYB8FBlwZFoirwxfq5MfECiAQDWmMhIsAcqSfnuW2+Kgcq
	 7YsAmkzFbBqZ8nDiVEVgnsPJzE7FRBfF9GGICTJOJcLtuUrFZdOIlhSOM6W8VsliZp6zC
	 DXo45xvvhy1khZeznFTtwDThDKAMDbBXeIg3RsJabJk5Z/Teu2sHJA6QD+Z49XWEb72dw
	 wiJGf3ukNu2ZaLiOyzSc33/StTVjBBtWTla49tfjvUzxODAajaMhyG4f/yYXf3L9ayw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=lPRRkpKl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mG+ib2r2;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7808606A32C
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 08:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7808606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=lPRRkpKl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mG+ib2r2
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D95CEC0ACD
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 03:09:59 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 23 Nov 2026 03:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795421398;
	 x=1795507798; bh=DXAyCJHoqpd7VVu9zCdoKyDE7YEOeTBsqV4rhJ4wDfA=; b=
	lPRRkpKlFKq83Jamzk9X4/Df7pnrWo/IJ/xtUes03zSRdwJo1segbFPanqNo2qo4
	P64NKFIGXChovTYATzDXS+6HZW9sOXvVqyFnFEYce+OeMR+Koal7x9V4ARiaKEHn
	cpiTlQkGS9pxBNMUpEOibeNiIjO+DxqZoSCtKupu6SIRq9+GiCRyamPjSiuVnYGZ
	zbF1BexSDj9wCS8TYfh6oPxj8kOLI5V2kfncq3Y+0nHSF0a9T2zoBcrxBLkAYD77
	Gee8FJtVnyMtDVlLPCxWzY932euoXSt7MjsDd09BR9Ho4+tdXHkm2hA4qfvNiMox
	4dNi5yvLtvrj+pc7y3fCRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795421398; x=
	1795507798; bh=DXAyCJHoqpd7VVu9zCdoKyDE7YEOeTBsqV4rhJ4wDfA=; b=m
	G+ib2r2ulVh/SuEODyW6iQI6+ecv5AaSazGoT3Gh1ts/U7FSVx/E8rtULq7Zd0We
	Td9KCU8BWTZcR36fRTzz31Yp1sPZujOlEdXH7U9IBZhFG6F+8qGE6SD1IkVmuUhw
	pNSDPChULtXAAd6L4QQE31yn/ZoS7cpCQulfGlpIwsPct77L0wEoNBIMEnM/p6Zx
	akLACW0ASn5RAMcOyeoppp/MNKx4Q1IB4GUii/fMqG6NWsCeC0o3AP9a+xwNdOWz
	fKNLkjgeTG5Aq4fXo2NCoitbPqSF39ciLG91tyqGt77R7xC4ZsBQLK4NlJJBAJmX
	K/+htk+Lz4aKkrD/gVZkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795421398; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:lAGJGwwe8ZzDWJZgyANjKTouAQG+VitAZEqU+I0EI0AhXF3
	1o/A9go+WYYOJzIstWrrmuwF4z2oksTuciKAM7K2jmaNg48J89ZAx1SNc97OfPu8
	kaaDb23V/ei6EXj6YwDDwLcRJLvdoqKdOlmYbpz/7mGv+HWw3RTx+QhJTAV/fptq
	K+3s7DZw4sjszrzIB6tyO3jv1rvkSINiKNszS6raH8UMQp/9kWmukbuSFibNVkYS
	7vIArdosZF147s7QCDNzGcOjkqWk5jqxuwVQiyKGGaeNIic4i+2WJyoIuBo5Fram
	9/0HWRRYOcfW2qJMxFKcWfoMMHj8zShY7gaVN9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:grlJwVnba3gqjUqUX7aVNCd1zkOWofYmeFpKttnzwyE=:jV1zjdHIqi/aczzkcsWrt0GVHwRxvf3JsPMWbYOic4o=;
X-ME-Sender: <xms:0_QDa5i2tYp5TIhibFyA1SuJ19LS1urtbxQcClYlXqxUnGWIMetP1w>
    <xme:0_QDa40iGlGEWOb6kBzs2cA7GRqBR4m7o8LLkSy4GDUn2l91jhkZxufugMUfQy417
    MYupiX8lKCQnXxLdZJTewAKRPwk6LnqWM87TjzQ4ACyF8yjCsTRkU7O>
X-ME-Proxy-Cause: dmFkZTGzMCPMWZZSopTfIQNPjqAoVr2afyNiJo/Cl+08OxPdOZHuAigQb0qVAUWJibca+8
    v4pKOhF9qMg3NptmPBeqJpXRKqy0zveoT1wbxMy3I9iRuHJPPfVsmCP+EzGBsETfpkCrMA
    LwPyPz2evOP3HTFP2K4kcZZNSl5sy89dEUpvnA/Agm+w/psiC562xv/QPN5COIp6Jlctky
    xxQqgX2xpvGNaWm1U9bTWLNfKErNqFnuOXZxxzwkQC8VK88cO0LMF1qDHIfTiU05NicLrJ
    jSEuaJxLi3svgEh+cvkrMPmUW1oLryW1JbbFsuM17FL+DcYuYxN15u/xcHGuoKKz1DTIk7
    mCFTbBeLrw+EaFgPIX2lk21ejiJm/IE5Lqe+nLjsGXXxGqqqbNEgh8OJRbddrKSJjZYkTZ
    +oecu//5XvlPJiGckWZnUgAw7fpL5/V/q8uVSujUhI3EjSJ+lF/8Yih2qdiBngRz1xrkLC
    S5+gD/KW8Thn49H/D6pHFgTOlFV5zNxudX31sVwRHxB2TDaybDgXcSv7SO4mEWM+Xbi5TO
    +/WYWOHJR7l8GSsjFiZHA7x+gyEx7ykdM/Ex3FsXFlxvRqV6FvBOY3skQuVlwLmEoB84og
    QYYMOfgCpmf0Ve8/rk23ZDfJClr4dT8bhLHc1V2yeYisSl+964tePENSTf4Q
X-ME-Proxy: <xmx:1PQDa3L9gpjfPI-R5gMo8DKzvCk5iKwu0HjWSwlsBy50a_pm1rbt_Q>
    <xmx:1PQDa2mjKG-QCIOqeo6iMFzXSpO2_8q3V8LJWpV9bC_4zR5apQvwaw>
    <xmx:1PQDazP91BHTQ18tARjlag0jwveQqfz8BELK6jKHHPQwRQ4JJ_DXng>
    <xmx:1PQDa02HXLMokXzIWtKpLasoICLPw4hXjZj6sDcPfTwGI6WwXLJj2Q>
    <xmx:1vQDa798Mfq86pczELsGDvSZWe7rQUfzu4nulvqYVQetlGvOKfF7iUmL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4F78832A009C; Mon, 23 Nov 2026 03:09:55 -0500 (EST)
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
X-ThreadId: AUwtRUbRNqlg
Date: Mon, 23 Nov 2026 09:08:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Message-Id: <423ac235-513e-4850-ba1c-5fe98eb2b294@app.fastmail.com>
In-Reply-To: <20261121140444.57953-1-fangxy@xiaopeng.com>
References: <20261121140444.57953-1-fangxy@xiaopeng.com>
Subject: Re: [PATCH] asm-generic: bitsperlong: Remove the disabled BITS_PER_LONG check
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Nov 21, 2026, at 15:04, Fang Xieyan wrote:
> A FIXME in this header asks to fix x86-64 and reenable the check
> between BITS_PER_LONG and __BITS_PER_LONG. However, this check
> cannot be enabled because the two values can legitimately differ
> when building the compat vDSO.

I think the correct fix would be to stop the x86 vdso from including
this header. The general rule is that any VDSO code should only
include headers from include/vdso/, but not include/linux or include/asm.

     Arnd

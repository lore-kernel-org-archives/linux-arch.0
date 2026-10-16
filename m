Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1583B42C9
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135035; cv=none; b=Mzfjs2+0qeHzpHrBl0k4MUb7IbDGlkZX+4UnWLKC9gQFllhrCNfM9mntRWqsCi8TooYCh94IVEkbp8f+VaYC+24P3mAJEq2GCruPSJUnh/98lEvzyaCum3Elny/zYEv+3WnYhXF7ejVwB/LCiptbK4IDbU4dmXxGKhkEAes8OII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135035; c=relaxed/simple;
	bh=HPXyJv1nnsRYyUIjP1OoOCCsi5FbA+9VtPJjoy/xgM8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oXYMoZTh/ubHb1U7UYkO2Le8kGeGncv48BBsmnBuaWlll1nb1T86PU59dXSRLv7BLuKs2nfAe+3cQbv0Tb0iIX+FZ9doA6KzBv8DjHXVOO+ItufFA5XOxXCP/5CX+933VGjtUqYxPqfiSgRJHMTHvPsHDJPTtQU49v9GrR2M1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=B0sNBfhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOnzLmwr; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="B0sNBfhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOnzLmwr"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 35BE31D0003B
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 03:17:13 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 16 Oct 2026 03:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792135030;
	 x=1792221430; bh=QL0dlcySmDzSK3Z2ozZI6UneSidlB/1C/LIGQE4hSiU=; b=
	B0sNBfhsB+jbGVd6Bw2wdUfSgVfpmjskn9XyuYyrfqMZubetdLFfu+08YxQXXDs6
	lIXx5p0Afh4yhynh/5xXW8n0bdWC6/a+ujQ/spq+gXJypqtDt5ftycectVoPRTfY
	Skh8FmJcB69xEqx4N213DIdrlzLwWEgRIqvfrniKxfJk7JcBe8f0hcm7rE2V844v
	WSiA0MTyC3W0PqM9OHipFeDKPUMCbuITMVnmP4lua4W64vevuadld99x7xaqCzoB
	Uv4Yh1+HF7xBVyFjsla3BijY4kdXOxazVkHfcYlzZ9SpsFLiIImsjDAAxYlSMOHm
	EwAEsM4T5wMTTbmE18RmUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792135030; x=
	1792221430; bh=QL0dlcySmDzSK3Z2ozZI6UneSidlB/1C/LIGQE4hSiU=; b=V
	OnzLmwrS43ljvieU2Q8ebT0CRFd5rat60+JJvyXo9g1rqzHK2xGLZeqQTX5Nxhjo
	irK2QzRSe/5zicu5ecmJeaayG91frvlXSdv2OnTQqMcYS0Y96oMUQ6tAPiotldmP
	N/dEJR4iMaU7zdyrcx/4lkyzc6Op1wXoS/WhXwnYQlpCeRPOhwMYlFi0toxI9/e3
	K+tCyuyomNfpInSa7nBhzQjkyiQul9b2ceEleJuUNczs570ii6pDR2x9dBrnV8GX
	lYCQSsAhfdX2B8fsrLOkayQ/o3Y1yQxgxuNAIn25jKFQe2lrCA11DkPiBI91JwLh
	5vQrlLcOGAs6bUzup7r9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792135030; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:hGGIZ/j/xpoXdSO9fW0tRwaaJWOg1udKluXAGsq17AmkWWC
	f91n5Ly+CPaqXP2i0wcU/WWag7OL/JAYhZ8yY5seGeVqrZvc2Hnw3OFQ7qZNUSpA
	IVJSaH/5fKUxSZCG0xEd3ndna+lgiVrRBsxtakNTLTt6XfmMjS9i2Oba5xcK5mwZ
	nsgWw8NfGO3toFrMHU0u3+d34IdW0ygXygSBeUqpY66+9Vu5yAmYRea22IqjoHlY
	xyOcvF7EcQB7vrIIoi7ZdZeQ9Wsu8IfpMir4k9VM5w0CqHwP2nyzHG8G35zfZxdc
	+jm/kXQOdOw5OdjlKkRwgCY9Jk+WYrZL+At+9vA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xsgxf6qOO/V/TeS5oaWMxRLaNr2zI25evkF4sFizc1o=:HPXyJv1nnsRYyUIjP1OoOCCsi5FbA+9VtPJjoy/xgM8=;
X-ME-Sender: <xms:dM_Rano0pG_DCgO8QbIPqZQgBcPswQH2GhxMBnMPQaLvJ07gjFia4w>
    <xme:dM_RasfHFhg0neFt0VzKB9O3wal38H5wpGeu9WtBs7Dayu7qxbCR54sC1OS-Y5ETt
    w5oo1OI_YEMer_yxqxut9qES2VnX-cvJ8YVQvJbBAkX0Qb91__JMsM>
X-ME-Proxy-Cause: dmFkZTFpbIEowVz8WtaA6lnOpECHfMBzcdKJWew9O0jHr8qAHFtVshMJGs0Xte0eVmutYU
    zNg6YHJV1jc7xxWz4ik6sMnqKSnnH5iehx4LVVenLsAMvEuXwd5BpvLt5uBXSHaoPK2BP9
    RYNPHra6v+OSIpNLKK3fFRS2eAvYWNyWoFJi2tTbkp0s4UcuTtcQJOSF7/xIJH7rgJ+3/Y
    TQ7urM9WRnUzaMrOPjSNKbdjfMyOgPHoEqOi9Vns9198nGEt75zotq0fpCVWxnKp8/nC94
    gfQEDBFMAfl8zLT4Z6gekt9szX2Jk8fgR59hdBe8gXaRvG2vKmueATPeK1GBZVlm+O29rV
    gtt88W3Ktr4z+to66X7PMuS+/7YeDd7NS7/XVyjHglrlJb4xN5P0bUA67HCByxTGHyXbSN
    23COX10hJCebwXjT6Hn1cuyNjZd40pLiz5aFAJCDpPfmvATwsBAawWQsiqp5cyjHR32HOI
    pIwKdtaHlbn+pTcW+VKXhl5RYYSDcBPcmgj9DMA7Jc9snGsLCPOmI2AneWWyqaOLJMk6h7
    ahhYSuAUSE+YS2UzTWsW7fZ+p0I1RTVi2D+QmKvigSu+hrmrlrZVdSPNwmKnAKkPAVJ78o
    7l+2j2EQKRMbqLjjWl99/Gc8t/uHpJ7ktcjbx9b8V1cs0UZlSe6grT7OiPQQ
X-ME-Proxy: <xmx:dc_Rao04bpwbZ4SEn9JsiT8BqZkgyx_L9pFUn1MqDpfUFa_nb5A7sQ>
    <xmx:dc_RasAbtQ10VlKOPzjGbPdBoya9t7gd7bM7DFuh6tkr6mH6FTFKZA>
    <xmx:dc_RaseYRPgQheCV2W2-8tjIHuhD-rZJrz0xEIpLmjvBXF6-bIzK4Q>
    <xmx:dc_Rah4YXbeC-u_vdtfuxaWnfqC016IUVC4RjENmq42l_Lzb1kKh-w>
    <xmx:ds_RakPM1oN7gHwhsepIp65kxtJjfhYjiH84GpwJsr7lj-rQWr_MkTJu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1D42E32A008E; Fri, 16 Oct 2026 03:17:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ8BcjErQSfB
Date: Fri, 16 Oct 2026 09:16:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tzu-Ching Yang" <shingekinocore@gmail.com>,
 "Yury Norov" <yury.norov@gmail.com>
Cc: "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com>
In-Reply-To: <7eb58dd0-99f9-45aa-bdf4-9707a0c9e1b4@app.fastmail.com>
References: <20261016025634.2690862-1-shingekinocore@gmail.com>
 <7eb58dd0-99f9-45aa-bdf4-9707a0c9e1b4@app.fastmail.com>
Subject: Re: [PATCH] bitops: Share the generic ffs()/fls() binary search via UNROLL()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 07:54, Arnd Bergmann wrote:
>
> I don't understand what you are trying to do here, but I don't
> think we want this change: I find the nested macros harder
> to read than the open-coded version and your changelog text
> fails to explain what the purpose is.

If you are interested in creating helpful patches in this area,
maybe you could work towards eliminating the generic versions
of these functions in favor of using the builtin ones on targets
where the compilers produce sensible code for them.

      Arnd

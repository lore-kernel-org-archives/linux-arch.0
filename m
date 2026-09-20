Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB93DAADE;
	Sun, 20 Sep 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891727; cv=none; b=cBDAK3+aQ833X1rsyW6SZ4H54esciGqBEaO/7K3IAkDnqeL83VhAhTfZJm4aHwdaMMGCw4OPSkFE+G+ozIiLW0lrDTjYBQJAw/lmtmf6BY+rWjlxJR6dC6LXgyDyxhdUSBUl2qcsuRgoNMfI9N+L5KuJhIuG/+3HAA6FRflxpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891727; c=relaxed/simple;
	bh=3atj+qkbk+R/Zm5QkNpTt3Uw3bDiGCHB8RcDtToni6w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YX6lqLzl4LTGPMnlmCTByLX8csLdw8gVYfS05h0XU9d8mFWcId8N2mUJHLQXCrEzjZL2g3IkZTm9LeXMiHJSkSEiWVTjzu8uL+8GqXPeahTc6cAuPAzvC2b431Sd8TMO0gnRsE/2CgTLjliS9k4hmC8TAyngaQ03BuAccJlUVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hiOdau3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7DryOvc; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hiOdau3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7DryOvc"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 8514B1D00126;
	Sun, 20 Sep 2026 04:08:43 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789891722;
	 x=1789978122; bh=ffK5pX2P4j5nnWE22zdQRvv3PmDqc/mpfQ0x6JR+bGY=; b=
	hiOdau3tJseanN9UGeT/hyopDUq909AEOSOO0qPPRfdWa7ROAcZutz1If4WaqCrg
	E2fY8hEw3Oe/q5HR6G5ut1TcSePahiSlpZCrdfvutF4q0rlp0cOpcEO+gu/07PwR
	Yr3tMaxtlZwwdVur6ZU1xN4G6cBTdyBkBz5/Asz7xUPH1EVn+pWRV9yYvaXyihCY
	k6wj8/fGe1ScY2eg8P9gxT6tfYLbC86rnRPQm/t6t0ZvkS4Xgf2BPV+TG+dIl7ZD
	0l752YAEVxjF5eDWcVfEqVuS60TPneTZk8BPrISlKJHyGqPyEJzF8rcFikVoyiCE
	L4duObt5n39aUjmsbBjWRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789891722; x=
	1789978122; bh=ffK5pX2P4j5nnWE22zdQRvv3PmDqc/mpfQ0x6JR+bGY=; b=n
	7DryOvczrfjQJfyMjLdHexgunoqVHlFk818jo9uvn7uY8/OKoGmdHB+VqS1/oGQ2
	PkxX76Yo+wJopHViGDVITykPDP03EH9A+kC3+KKc1M06eBWA211/LOJSNzQjxfhn
	sYvtVffuSaY1jwUZlP7vXcl0V62hA/0WCji8BpItIkz7uCBlpzUUeuj72y/+nXeo
	adr1mo5fKDbPkAMfnq2HoSaNBv38OhopPcg8+KC2jWK68kLjKEMaaWkmN4GCpVEL
	KczxxJOlMlazVCTLtvdgyvsDw7hkCeb6clIFdDKWg3nHMZm6fM4kXlKA0prKHQBj
	ZVZ+G6NCnhnSyjwLQLUTQ==
X-ME-Sender: <xms:hpSvapdlT71GeQBqPZSRYIB-xqGX-MDxrSdXHyiI2C0qX_fQviH-7g>
    <xme:hpSvaiC_1mTNKngEjzU7Lcg-GyPS40THRpLJku8n4LU33rUSgvjP6j90SgMeJOR7V
    D6qNqvkpt-98xih0uPef4y90uqtKI1U4Gkvgnh13EF_k0nnvPJ_0dIp>
X-ME-Proxy-Cause: dmFkZTEApUgzq5R1VaYiB8MFrbvSFPa+DmFBNJpZek7io0x5WLEWe09xu+8zMYW6sFCQ6g
    nFVK5n2aPOk/a2gPj9tQY8VwDW1SIxgI3P6nBkQQc5DVUsmNCfGC0mopPl+MAbInY/3Gkh
    j0YtB97ONIuFQCUaey1rx+FiG/uJeaWXejjymul3jWj4pBlVuIMlWQdgSoJPwcDLbOYrKb
    W/TUNj2FtkB9gyurLT0GrvyXlRYrCoh/uwO0BS4Zri5uB5QIp4yj3SooL+cOHjgjKQtcMb
    9d2HJzy4fsnlbbhKt93gcSZtTjLDkhxZF51yQ0w3XOdLj0F6NFL22MAcr4JWdAfCLplyZW
    wWEqAWjMEfytO0Rh/kapbNPVE6WW1ip4gAliOVTuKEHbZzcoL/5evojz+9Qh7xQcL9UR3t
    BTALAIap1b6rOxA1GFZ9VmqBCQ3HHtwHIqukmmoj/8B+LGZzvhY37xLsqw92RWKz6+KIIz
    rwpzlaKV6FBvN/ZqqZfR84PjC4aL0RhSnS0piZFdQcz6dSqy62In/l+E285g//lDNsAyMs
    yB/XXat3PiOZzNjjjVCvum/qgj7SsL9E8sqNOFaEL3eclFuefgBFBqWh5o4tPIcHzZjk7d
    5Z/1IXBALmuFtxnUuSKpWU7T4GfDqAweCSuLQhkTBK1TStxGrds+bVLejX+Q
X-ME-Proxy: <xmx:iJSvako9_b5zIahQiQuDfJiiV9qyxcKyWlq2W4-9Yak0cCAqD9u06Q>
    <xmx:iJSvavDNbEvGcXrj7dWmpDLHMTtiFYNyky5vuEWf57ob7KBcgNe4RA>
    <xmx:iJSvanGMRwr1-DZAYDSpJrElc37hW4YlZ35jhwHMQX2f5IVsFQBVPg>
    <xmx:iJSvap3oWmXMTDesGRyMGSctsWmhFDDHh-t7ldvXZIMOviM0fXSEHg>
    <xmx:ipSvauadPHzJOlhh6ASLyqa4GQbzyYwg_SC3148ZXvchP1L6KWNPTCv3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9F89132A0087; Sun, 20 Sep 2026 04:08:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzgOxjlYMeWB
Date: Sun, 20 Sep 2026 10:08:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Vikram Sethi" <vsethi@nvidia.com>, "Mike Rapoport" <rppt@kernel.org>,
 "Shanker Donthineni" <sdonthineni@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <5847c824-8d69-4d02-af2f-896bf47f0732@app.fastmail.com>
In-Reply-To: <20260920014357.7069-3-qingfang.deng@linux.dev>
References: <20260920014357.7069-1-qingfang.deng@linux.dev>
 <20260920014357.7069-3-qingfang.deng@linux.dev>
Subject: Re: [PATCH v2 3/3] arm64: use generic MMIO accessors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 20, 2026, at 03:43, Qingfang Deng wrote:
> Use the generic raw write accessors in place of the inline assembly
> stores. Include asm-generic/mmio.h after the arm64 ordering hooks so
> these accessors are also available to the write-combining helpers
> before asm-generic/io.h is included.
>
> Retain the raw read overrides when either the Cortex-A57 erratum 832075
> or NVIDIA Olympus erratum 1027 workaround is configured. This preserves
> the alternative-patched load-acquire instructions and pre-load barriers.
> Use generic raw reads when neither workaround is enabled.
>
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Sorry, this is no good, we need the compiler to issue the exact
instructions from the inline asm here, both in order to guarantee
these can be virtualized, and to prevent it from splitting up
larger register accesses into byte load/store on unaligned pointers.

     Arnd

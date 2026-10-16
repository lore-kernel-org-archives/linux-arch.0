Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6328B4FD
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792130218; cv=none; b=uH/2gQJYFXyQidlpbH95zJm3diuYn2KrrO5oFSIlHOaLufaWmiN3jvBpzjCwnt3pG4ddpz2+d+KxrEzpWWOKv+olT/4+6TzUis3zjfw4/QsafO5qF8oZ6+j/aJrPrB7xqJgkfdpM0TwvuJjT9xwXNw2LksHyVcBTWUavKxj8xBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792130218; c=relaxed/simple;
	bh=8L8HzNgF6UOk2WsNrdDmE1W3zYL26KSmgD85qAfB+6E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=URrNG+B2XfQ0MCvmrWSwNmGT44vl+1qg3MKl2KWehuZr6J3MiZ71r9GYMLyl8Jt0xGi3fDOp2sNPwHPvqQ4S+D+XpGn5IzzRWh6EpuT4M3Tw+No0hRX8PNIIWGW//480jvdJL9kLG/Cwl/iFkI/iBvaFE8p8YKiSB9Fa+kk7inA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Sx6FHmso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJizv4a/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Sx6FHmso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJizv4a/"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id E044DEC0116
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 01:56:55 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 16 Oct 2026 01:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792130213;
	 x=1792216613; bh=lNSrLzG+uV5sUgUaNCSkdhQ4V/ofgesAl8PShfeqIbA=; b=
	Sx6FHmso3QouPijgUlsaUePC2QmFgGQYqTWlcbtKHqPMBzBZccoTgGyGkTSHFH/j
	BG/vlHIdGZYiC4AcXvbmIaZlhNn/4pz4EHMFVHXaOalDqiF50PwVCyLRATQ8rIat
	UHelzUbWv3PzQ9TNfANZZTQIp8Z3Eg8m2mOVQmM8h3gtiYatvIhznEV3JNZW5yBZ
	fdF2JCUsnPGvk85pU7Zb6DtFTAoHg+kMKJK+v3JyM8+WLYHPgDaYhfAcQGrkoCsO
	N4AlG4ZxGizQcED2VVnUv06/xvdpyrN5IHc7mKu1r9PWx0tW4iAstLrecpKA7O0S
	T7XXB3e4667ZpCd+t010mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792130213; x=
	1792216613; bh=lNSrLzG+uV5sUgUaNCSkdhQ4V/ofgesAl8PShfeqIbA=; b=m
	Jizv4a/dmWCRPgNgItYYo2ZFGTyKd34PFziC1GMKjY1iz6x7rBEEZrHtSyrSncxf
	XImwLHWOHyQJdFKom4QrWLs8AlfUAkKuaU9LYFGReF+mDTenGjm5+sVjmCdLpUQD
	mn73l85AXZJJ608YbiFLp0wk1UJyLyC43lwuIspp5dBxyzqPXLVPUQtS8JsP+dMc
	lNhJ4F7VFY3ALXXOLjn7tOq9PSEnnElo3CT01eae/53vne63BlOBzEd36p/s4/Xr
	8YFTZgqrGKykjslVhsn/A9nvOzVQYSG9GpWVFJehDvT1uxcJ/wn0SJ3i54Tp0aLq
	HHncmQs64O2eUHqMC1fNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792130213; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:S0bcwGLuhnXzJQB3AGkQS7aF1GCt4NPm9SU4K8O7UIq2Zuy
	4HP5xWy6eR1udwAzAPeVFTrPVUX6EdaYLSuu0HWkV11BMZq2CDvz6zTQcMzMlSmZ
	g4DebBpwx8yvrNnkQ9jJmTJkj+j8poKTeznSNk7+6xkwGKm9n9biMsXOOeim4ef9
	P3VwFjVXjNB3lMnsS5x8VI6MWRcEf9CDH6i4VbnRPxNbWHoW1IAe5+BjGwHf00jh
	zH+uHr/CJvKAQi+HzkCIVXRA8AY8VlhYISQ1SGUwi8sk6PUbLuAT3uQWi3rhHa1k
	RZzoVjwSUcgxbxAitJdr9ExrPh76H88I2DX63Rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bMqNEJXtgGarsJ8kSglbU2UA+ASYKREnCbMVjZKtGsc=:8L8HzNgF6UOk2WsNrdDmE1W3zYL26KSmgD85qAfB+6E=;
X-ME-Sender: <xms:o7zRarOw3-FrPnUe2xySoK89zoP06IBJvO4efEDZejmCoDd5D0sKng>
    <xme:o7zRagzikR-CinYkuoziNHxSmHJmi4of2ha5rEPmIEWvL7SQlzJ8RDl8wwB3gU8-8
    G4lg9Odgg28uMhb9HIj8stlRdkCRLzuzZMGNCfROl_4kkwyJp5JrTo>
X-ME-Proxy-Cause: dmFkZTFJ7NL4BuKdK9/TOR1cLmMjzwgneETDDQl0CBSBDEmR2uqX7ImE5xXXuidhw4ciLj
    n187L/rLcROIWkVVwOppYq4ZYzp0/qdSxJzsWT3Pnf7hNhok1YPgAxUaiJUOipQFV1RAGz
    XvndiBYdM8tOfCRt/9ghZb7iZ1e9muSzGftIijhEQEE9jVnkUUvpsdA1tbdJhqs2rcu2WM
    MAZgAe+FDtf7+HQ35htJL+tly6q5+WWJdc2FPPPaO4FaCvci4hnKs8medHljarJQa+B9RJ
    ImbiXI3U3qA4+bdH875FCbx4aCQARrZ0l8rX2Z+z7ymeK4Bz5X7WXDr8Yoqmjz9xraV4sL
    rrU02bqtOapEoK4jmYgifCFK062KmT8DwKB638lhY2tnA68uE/G0a7gb9rd38uDAU22Qc+
    3k8OEAEwTIGGoirh0LaTmUe3lO1mFE7EiZ59r4iak86vGu5ypQ4hcRvVeddt8ZI8IfQjbM
    q+hIqL6JAnuqam6EgC5EVbNWaLyaOphh51JVh/qbXc07SyHg+OylTwbFC6Lf6o8Q89tVxk
    uy0yAEcX19TubTNhvXm2919CRRBouZv/8JagYLPGpxVQci/1Np8lCj7Jhw5h0ptrMsuHz0
    Zx1Ctd8xJikYTW1YMSH35AquaXW+IEfXsMad0c1oM0yXyrJLtpxt8CEjYLHg
X-ME-Proxy: <xmx:pLzRata3lrQxy-4AWiLFLDx00h4mgUe7NAhx8A79dLliEMz1T2bpoA>
    <xmx:pLzRatXjml7r78FeanKBCrRqPgPUG6kt_HVIAjjgtYYle9rzNxbJmQ>
    <xmx:pLzRarinOYVtlLe4Ss8Db6mWZBu6O049bMdKAMbNB7-tV2tbBwb-Sg>
    <xmx:pLzRarv6TKs5akK6QGG5KEs6lSEUoBvgN8SiY15WyXgIZkxOoxcnLw>
    <xmx:pbzRaszg8jRxU3HZjenKPEXQ0j2zwcAFFQjRp8ylET6zB6QvEDkOqS1z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 67B9732A008F; Fri, 16 Oct 2026 01:56:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ8BcjErQSfB
Date: Fri, 16 Oct 2026 07:54:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tzu-Ching Yang" <shingekinocore@gmail.com>,
 "Yury Norov" <yury.norov@gmail.com>
Cc: "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <7eb58dd0-99f9-45aa-bdf4-9707a0c9e1b4@app.fastmail.com>
In-Reply-To: <20261016025634.2690862-1-shingekinocore@gmail.com>
References: <20261016025634.2690862-1-shingekinocore@gmail.com>
Subject: Re: [PATCH] bitops: Share the generic ffs()/fls() binary search via UNROLL()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 04:56, Tzu-Ching Yang wrote:
> generic_ffs(), generic___ffs(), generic_fls() and generic___fls() each
> open-code the same binary search: if the low (or high) half of the bits
> still in play is zero, shift it out and adjust the result, then repeat
> with half the width. Each copy spells out its own masks, the two
> unsigned long versions need an #if for their 32-bit step, and the
> copies differ in the order of the two updates in a step and in how the
> test is written. They implement some or all of these operations on
> riscv (without Zbb, and as the fallback with Zbb), ARM before ARMv5,
> m68k without bitfield instructions, sh, sparc32, microblaze, nios2 and
> a few other architectures.
>
> Add <asm-generic/bitops/ffs-fls-search.h> with one search step per
> direction, whose shift and mask follow from the step number and the
> type of the word, and expand the steps with UNROLL() from
> <linux/unroll.h>. The four functions keep their definitions and
> kernel-doc; only the steps are shared. UNROLL() works in the
> preprocessor, so every shift and mask is still an integer constant
> expression. Its count has to be a literal, so rather than hard-coding
> six steps for a 64-bit word, expand the 20 that UNROLL() supports: a
> step past the width of the word shifts by 0 and is optimized away,
> which also removes the #if.

I don't understand what you are trying to do here, but I don't
think we want this change: I find the nested macros harder
to read than the open-coded version and your changelog text
fails to explain what the purpose is.

If you have a specific problem with one of the platforms using
this, I would suggest you address that one but leave the
generic code unchanged.

      Arnd

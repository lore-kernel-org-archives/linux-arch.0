Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588981;
	b=Uu+XaKgnfigMcfD7//hEN5fnC1lt8liVvOCacB61cS8X+ikpq++N5gGQb8kO/JAXocuk
	 LFj24+US7/vLqexgNneMFKUZGs7bKHAw8kuP7t9pRISFe0zr//duXV+BgGBqgowtRoCGk
	 XS79pYa0E8FL5OPX2GixIskKI22oB8KQ1qC4+It8rC2SyqTAcGKogjHME5eoEsRKruaCn
	 UVTUDqxzSj738j3l9ozYqcBr9Wuh2he4mUT3ICDJ23gvRg2rQ+1hZ4lnZwchCyA2LO5tA
	 KEmBXtHUPrSAygQ49wP2/b7TUavbj06JQyk9E5fixGaVirF9MOY/G2lPYdbdTkvQ1Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588981;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=aeKCpXddBPM3zqxLSgWii91zWsk60vmmQFyoSuWzZOY=;
	b=ypHyNphkRI0Od2CG/MXDLNGV8QLmhQaayuPa25K1NkTwJEdiKig7rVuEFh5rNKApNntt
	 DJ/WrC3YLNUGzFsRINrAaBqGabE6J6WIhV+huhwcA0ccG67fY24YIuKiLWSHdjK1yc6Wo
	 WI7O+JFB8i+mzJecDaArh3M3Ko7mprQq1mEYlD6wc4BYbSknpz6bQFWpUnpc7yI2oyoWd
	 au1Z3S1lPGHjsRIyDZ9iO/HJvGssXZb4O25/8JsC//5g25IDNLjmd1jT4RBzjtFu/qnIL
	 c1VVngw2/ahIG65BSX8A0SVLHNaE8MGqiS8JR/iXi6e3M/cabk5L2eCc/2LW2in0KbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=C11IswdM;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2712606A31D;
	Wed, 21 Oct 2026 13:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2712606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=C11IswdM
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j8qhx6W67zMlQQ;
	Wed, 21 Oct 2026 15:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792588977; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeKCpXddBPM3zqxLSgWii91zWsk60vmmQFyoSuWzZOY=;
	b=C11IswdMW66PBv57woN4BR138fbl8UqPdy5vgOb/POLi5vvUN54B1ov9C0naIXTNoKbZJZ
	YS1ge7w4y9zhhoQD90rahE3TKOgkOssTIFisbSd6M+H5X995cG2A21ppf52MLZKt2UGtJR
	1FfQJ4jvb6v3jjs2PcgD95L2/dd3qTRZ338U7OYxHrs9f24wQeNvdpKP+ZFhF1F+opZZFa
	Tn07Y72ckXqIp/VZRfkggpsRM4XrcgLonHk+M2bcrsQc64hu8FYp55g+nsJkW4PCBhOhHS
	OCVS6FDnN+/U4DQQu9ARnwvq+wMYHuQs2qjamRtJOkO3NbquCmfM3+ZGpJuHHw==
Message-ID: <d305166f022bd567cb03f8fb5c8b9f2aa9e6b5fd.camel@mailbox.org>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Gary Guo <gary@garyguo.net>, phasta@kernel.org, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes	 <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin	 <tvrtko.ursulin@igalia.com>, Danilo Krummrich
 <dakr@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Date: Wed, 21 Oct 2026 15:22:54 +0200
In-Reply-To: <DMAIIIJ57A3N.GXLM3L5IOAPL@garyguo.net>
References: <20261021095512.1345191-2-phasta@kernel.org>
	 <20261021095512.1345191-3-phasta@kernel.org>
	 <DMAI50AJ10UC.16G4TCC3VAM0J@garyguo.net>
	 <56108c0554e92191d2678a407d7d8102b9b304b3.camel@mailbox.org>
	 <DMAIIIJ57A3N.GXLM3L5IOAPL@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: 8522d2698eb6890de26
X-MBO-RS-META: aac61pah6chuy1w8d71zjmx86m7o33op

On Wed, 2026-10-21 at 13:24 +0100, Gary Guo wrote:
> On Wed Oct 21, 2026 at 1:17 PM BST, Philipp Stanner wrote:

[=E2=80=A6]

> > static __always_inline bool test_and_set_bit(long nr, volatile unsigned=
 long *addr)
> > {
> > 	kcsan_mb();
> > 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
> > 	return arch_test_and_set_bit(nr, addr);
> > }
> >=20
> > Where does the "full ordering" come from? I suppose implied barrier
> > then means it comes from the architecture's implementation. But what's
> > then the purpose of kcsan_XX ?
>=20
> It's from arch_test_and_set_bit.
>=20
> KCSAN doesn't see arch code, so the kcsan_mb() and in fact
> instrumnent_atomic_read_write() both are annotations to indicate that thi=
s is
> conceptually a mb() + STORE for instrumentation purpose.


We (i.e., someone who's got the overview) could probably document where
and why our atomic instructions are a bit scattered.

Why is test_bit_acquire() defined in include/linux/bitops.h, and should
set_bit_release() be defined there =E2=80=93 or here?


P.

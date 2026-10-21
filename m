Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585079;
	b=vSXRInFnAh5BFnAG3Wyli4JLCKeykuJnt31tMOGcX5eeBO1xD79QtNHyL6XyzgFJe16D
	 APcROqWkiyLcrrq6R6jMa7h+KY5mdlCeJFen/X4nUYDP6RzrWAsokWopo5kpus0zgsFDP
	 o0R0cxXjbWcMiYrNl2y+Gzn8V5X4NwTMMNLdE8qRIp5us8u9ERxD+veyZjpZ8JhnBB5RV
	 5LbCxDciX8s4s7kq3TevnitbzUXxjUtPxoYo+TZ1vggqRDry55AdXgBInSdo5M0pF1dvK
	 FsHVczkVqX6N/drRtzcL/IorJbqfmErpDZ9I+zH0bSU2HAL+9i3Iim0kn6Mc/O4Xdpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585079;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=EL/eq4tqRBKCnxJksbAykL7YqlgVBJig3gdviTtcTSM=;
	b=5AvMvPdZCJ/+qchHlr3ebYp95OI7FxNGZIs8KVTb52KdXOH8Vs3vpDSMXzz5Y61Ny1d9
	 nH8bJ6euk8DxsVIDwcij/3n8g6rmtg7C2nU2eHsKAf3LJPgVys0+0KOCsFGzcjP/D5fy2
	 ssmGMwmO6VYAUo2zlvdI+nnr2dKHjb6GqFVpcmV0GB0Y48xYyHMJI8CW2IX1I58fgKJ3i
	 GM9/gCcnTIOCWHc29ZiJKZVuoWKuJRH/K8LnIVezTCbrO/XVLYKRgI96yLBFEoCeNEi2w
	 Gyn84YYA1tMAJezLIqgGMpVfn6qbjQ+kniF9cEnS84zWDQw4YImWgsR4TSqGsStPJjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VbjdF1kZ;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C9606A33F;
	Wed, 21 Oct 2026 12:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9C9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VbjdF1kZ
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j8pFn4tS5zMlr0;
	Wed, 21 Oct 2026 14:17:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792585069; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL/eq4tqRBKCnxJksbAykL7YqlgVBJig3gdviTtcTSM=;
	b=VbjdF1kZKbhdrPcdURRa7MKe9sp98fFHrCWdzqC7/z/oUh/JmYFKW5v9722X9Yv1fULsRg
	dVrnXUJfhMqNvjTetdwMYrP+HCG0vn1KyrxzIq8KAtJ541moVALzdBSBXk9XPtkCRJJnHW
	Kqh4/sjVapP2UHig6mKMKSaBY73wY1KI6h7nUX0ZK8p2VIrN+N6VsUlOHrwVEVe5ZwNvTI
	EqhwcnReGAYTRs9vMst/YL3D469kKBz2Sy7pvAWHWDjyzQlu4MOtSSI4IbIt6M8xoVa/4S
	y5D7HTh8s1jJDfFCTaRZJDApN7P9t08WjPkyuDYwMoPh9exUGRZ7wOUfodaaxw==
Message-ID: <56108c0554e92191d2678a407d7d8102b9b304b3.camel@mailbox.org>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Gary Guo <gary@garyguo.net>, Philipp Stanner <phasta@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann	 <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Danilo Krummrich	
 <dakr@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Date: Wed, 21 Oct 2026 14:17:47 +0200
In-Reply-To: <DMAI50AJ10UC.16G4TCC3VAM0J@garyguo.net>
References: <20261021095512.1345191-2-phasta@kernel.org>
	 <20261021095512.1345191-3-phasta@kernel.org>
	 <DMAI50AJ10UC.16G4TCC3VAM0J@garyguo.net>
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
X-MBO-RS-ID: 3e1bf5ef4c04d1a7fb4
X-MBO-RS-META: boxbjstxupnn7c9nsjj15r7p89nf14ha

On Wed, 2026-10-21 at 13:06 +0100, Gary Guo wrote:


[=E2=80=A6]

> > +/**
> > + * set_bit_release - Set a bit with release ordering
> > + * @nr: Bit to set
> > + * @addr: Address to start counting from
> > + *
> > + * This is an atomic ordered operation (implied write memory barrier).
> > + */
> > +static __always_inline void set_bit_release(long nr, volatile unsigned=
 long *addr)
> > +{
> > +	kcsan_wmb();
> > +	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> > +	arch_set_bit(nr, addr);
>=20
> This is just wrong. There's no code here that gives you the release seman=
tics.
>=20
> kcsan_wmb() is just an annotation and does nothing. wmb is also not relea=
se
> semantics as it does not order LOAD->STORE.

What are the other functions here then even about?

/**
 * test_and_set_bit - Set a bit and return its old value
 * @nr: Bit to set
 * @addr: Address to count from
 *
 * This is an atomic fully-ordered operation (implied full memory barrier).
 */
static __always_inline bool test_and_set_bit(long nr, volatile unsigned lon=
g *addr)
{
	kcsan_mb();
	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
	return arch_test_and_set_bit(nr, addr);
}

Where does the "full ordering" come from? I suppose implied barrier
then means it comes from the architecture's implementation. But what's
then the purpose of kcsan_XX ?

> Given that set_bit is a relaxed RMW atomic, you can implement set_bit_rel=
ease
> with just
>=20
> =C2=A0=C2=A0=C2=A0 smp_mb__before_atomic();
> =C2=A0=C2=A0=C2=A0 set_bit(nr, addr);
>=20
> Which should be correct, but is too strong on some architectures (like RI=
SC-V),
> becuase it will produce a full MB instead. So we can either add release b=
arriers
> (hint: I really like it), or we can add arch_set_bit_release and implemen=
t it
> per arch; on RISC-V for example it can then be translated to amoor.rl (wh=
ich is
> not being produced by any existing bit ops).c


All fine by me.


P.

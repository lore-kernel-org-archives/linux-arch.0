Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011B338929
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769023497; cv=none; b=CBElgt8/KjcJ3bt9ok5TgT0+sHOf186nfqg+cP8Kv6T1oE3qi507dliRSFP8tjfWqRT25kEbZtHfmte98qag357kF+1DGrsSA4VZTjSY1cFnQvf3o2Q42fm3UxnqY4fNefhSSirKoJJG0Vi1aESYznZUvZvkCIZ5SJPc4SfcmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769023497; c=relaxed/simple;
	bh=gyTU4a01nJSUemuXWfV/RQRcTm0unLyKNTrTMAgVgaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRA81GRrTavaUFu6Gyf+LY74Woa/5fm7Bm0hJzZ9x0Pi7G2BeMI4PZTAEnOnBGEmqoPQpBM68Y04cxeT2d7zVjV/p/RJSc91On3ylwJtrJfNSoIOrpvvSpffL6LreKe72FvosIM3ahkoUg9oVd32hoMVQl8AVJbp4JzDVihtNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1CPZ4En; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1CPZ4En"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso1250025e9.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769023494; x=1769628294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElU5zBr9MQauCQ2KbtYpyRUNDArLPNpb0ZVER5AU1+w=;
        b=B1CPZ4EnvybEFLJNowH1tAojRrtgU0Jbxn+EMypYnRN4LK1H0DY07eGFrfKNyWxB2b
         HAdryWAscMTo0Gtit2zs2vK+fBoYaR+aF+HAR3HhxGNFuQivMKadfBCR3MGd3kXdCism
         vUwyjtaV7H8GyviqQoUb0O/dfrCm9IRW4n5KYbzpR2seMXe6VjT+FAJ8clgWxVol0Cnm
         YoMLxRDS+F1Ih8LGlpiLjoHyQTLkSTej4xJOmH1ZeDdD29YhLLikpMnpPlKgRGGs0Y6N
         h4LZg/ALGfmusFHdpaulQWVdJwRV33NkSTCRILBowDHS1qe5VxqQSmWK3NFI5wVrr7kx
         FQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769023494; x=1769628294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElU5zBr9MQauCQ2KbtYpyRUNDArLPNpb0ZVER5AU1+w=;
        b=GnMSm/J+Vh0N1dIlxwGaNK0MYZ1iBtS8njw5x2KorukrfxY/xUP+AznFxWesUdkZPO
         NJ1FKuF0oYG0g83dCwFYOPRbuec7JB3ctrvv73CUIwnarE0Mvz/ByrIw44dJdBnBuhf4
         XR+ABcjk8WJN88tCFbLarNweGivu5eHwsD7yVeF856RbRR0xBo0IDNBXZq4PmHaAes82
         6gaxexpmJ+Enc2x8KLMLyV4KXew8UgB+Ek28HR3AednvhsmPiMU5EiJ8PLtSrzk6eIT7
         zbZTlUGqMfzKwMCIh00dIwYiJPN0RVCQZZfzBsCo/TbI/7yf80cMTy9+yKEEt8jWIwP2
         I7qg==
X-Forwarded-Encrypted: i=1; AJvYcCWoXEhiIyYDrVYY6kCUTBEYQl6kT5eMmSp1vWspoeCpfkvB9w/BO5loNLJToTX1fv7T1VJKLxVZl4D0@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQrLhb+786xpUyao7ZBcv0sVEJIWyh7VtFGoCteqGwlJcZCgC
	EpzFMJo5SFk+1OtoCk8Q0pvjYjshgZc5qtfWZ5q9NGCUpoLmwhl/5r4w
X-Gm-Gg: AZuq6aJ3YCvmdgvFSrLnsaSXuoRottdUTyKAgUi5gJUUMX6JJ0lldUncFNFsRisaGai
	xKCyofTLvG0zemPHdTc+loQnzKsbaxm/fLFTsV+d7CDh0MloKEuO2r/UKsBV8r4rvaSsY4apVPu
	tnNWUBGIz9KBXE/RyNB81PQApi29P1JuETBQc0QJPLyK1jZnT0c81Wuoap4j1Zc6wMzVdDKOVth
	GQ0/F9BncwQWlYwhWadno8EvMDE9AFk88vXsJzAQK6EJGEBConMJHsFJ7uSeKIfGuJNEJVs9elM
	03atYP9R4Hnb08VMh5VW2sD03KH6i4NJzvm49ytFCwBG7jvuUJCwpneM7iTxiTLqUAEvfmF18mi
	5LTxA8PxK1T8LfE45A8HdtulqLDatt4lZBiPg6w/aLgcBAnBC15b6P58sZPEhcwA1NgIejGPits
	VAxfnsakPyiQ1hbQZ6uWqKFiBnJzQ4HsSbR9ibaY+5Y1PxWIrg9rod
X-Received: by 2002:a05:600c:1f8f:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-480470829c1mr9500585e9.9.1769023493704;
        Wed, 21 Jan 2026 11:24:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804245320dsm10228595e9.0.2026.01.21.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:24:53 -0800 (PST)
Date: Wed, 21 Jan 2026 19:24:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Jani
 Nikula <jani.nikula@intel.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 12/14] bits: move the defitions of BIT() and
 BIT_ULL() back to linux/bits.h
Message-ID: <20260121192451.415f1920@pumpkin>
In-Reply-To: <20260121160912-cafca67d-bfc0-414a-adaa-80c863acd93a@linutronix.de>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-13-david.laight.linux@gmail.com>
	<20260121160912-cafca67d-bfc0-414a-adaa-80c863acd93a@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jan 2026 16:17:18 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> On Wed, Jan 21, 2026 at 02:57:29PM +0000, david.laight.linux@gmail.com wr=
ote:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > The definition of BIT() was moved from linux/bits.h to vdso/bits.h to
> > isolate the vdso from 'normal' kernel headers.
> > BIT_ULL() was then moved to be defined in the same place for consistenc=
y.
> >=20
> > Since then linux/bits.h had gained BIT_Unn() and it really makes sense
> > for BIT() and BIT_ULL() to be defined in the same place.
> >=20
> > Move BIT_ULL() and make code that include both headers use the definiti=
on
> > of BIT() from linux/bits.h
> > Add BIT_U128() for completness.
> >=20
> > This lets BIT() pick up the extra compile time checks for W=3D[1c] buil=
ds
> > that detect errors like:
> > 	long foo(void) { int x =3D 64; return BIT(x); }
> > For which clang (silently) just generates a 'return' instruction.
> >=20
> > Note that nothing the the x86-64 build relies on the definition in
> > vdso/bits.h, linux/bits.h is always included.
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  include/linux/bits.h | 7 ++++++-
> >  include/vdso/bits.h  | 2 +-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 0f559038981d..3dd32b9eef35 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -2,7 +2,6 @@
> >  #ifndef __LINUX_BITS_H
> >  #define __LINUX_BITS_H
> > =20
> > -#include <vdso/bits.h>
> >  #include <uapi/linux/bits.h>
> > =20
> >  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
> > @@ -89,10 +88,16 @@ int BIT_INPUT_CHECK_FAIL(void) __compiletime_error(=
"Bit number out of range");
> >  	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1=
 << (nr)))
> >  #endif /* defined(__ASSEMBLY__) */
> > =20
> > +/* Prefer this definition of BIT() to the one in vdso/bits.h */
> > +#undef BIT
> > +#define __VDSO_BITS_H =20
>=20
> This is ugly.

It works :-)
I could have put an #ifndef BIT in vdso/bits.h instead.

> Why can't the vDSO code make use of those checks, too?
> Or use _BITUL() from the UAPI in the vDSO and remove vdso/bits.h.

I didn't actually find anything that just needed vdso/bits.h
linux/bits.h would get included - eg (IIRC) because of warn_on_once().

I'm not that sure why it got separated, it isn't as though it defines
anything that is code version specific.

	David

>=20
> > +#define BIT(nr)		BIT_TYPE(unsigned long, nr)
> > +#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)
> >  #define BIT_U8(nr)	BIT_TYPE(u8, nr)
> >  #define BIT_U16(nr)	BIT_TYPE(u16, nr)
> >  #define BIT_U32(nr)	BIT_TYPE(u32, nr)
> >  #define BIT_U64(nr)	BIT_TYPE(u64, nr)
> > +#define BIT_U128(nr)	BIT_TYPE(u128, nr)
> > =20
> >  #if defined(__ASSEMBLY__)
> > =20
> > diff --git a/include/vdso/bits.h b/include/vdso/bits.h
> > index 388b212088ea..a6ac1e6b637c 100644
> > --- a/include/vdso/bits.h
> > +++ b/include/vdso/bits.h
> > @@ -4,7 +4,7 @@ =20
> >  >  #include <vdso/const.h> =20
> > =20
> > +/* Most code picks up BIT() from linux/bits.h */
> >  #define BIT(nr)			(UL(1) << (nr))
> > -#define BIT_ULL(nr)		(ULL(1) << (nr))
> > =20
> >  #endif	/* __VDSO_BITS_H */
> > --=20
> > 2.39.5
> >  =20


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC71DF271;
	Thu, 22 Jan 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067588; cv=none; b=Z/ZOIjvuXx24pg/4CVg5wiO88NoK3QEXKLGtWnnje2UMJOE4LiwRI9UW35rCCMfepSgLKsLH97a/PBvkJHCjJ+HdaC2QPNlLo4Q2yFR5NKV/7tv/+rPVS+JAXMY6PXYQuvLaaXIUmDQP1Zz8XmVQOeG0rnzUBcInxULlhChJUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067588; c=relaxed/simple;
	bh=LwTgF82yTgz+NFQtKQdTrh2ELXy1y9xd6zn0plheQFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOXCyTEGlM2hNX3ffx5gmpoXgESlpTB7fy8VRk0LlpHda58FMR3xAUputcfod5+rbEVo4oiDMIS05S1RRr1oY7FLmGqUQoJKwa31R7H4JYHm7ihh2SXhgYEgHpFb7Wx68Sdio95TT2ylLcR5otwl0Emc2MkBIQ8/lS6unRKfRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEpDxF3W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNkNYCf8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEpDxF3W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNkNYCf8"
Date: Thu, 22 Jan 2026 08:39:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769067584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaS6uqL/kbrq2eJPLq2hkMyWIvEZct5vh85RpG7ja6c=;
	b=gEpDxF3WrRwRPtu0A+1S17dZCXhl5kEEm2gBajdKdrCTM8lE8yf/Qu6rjJ4bAIvj8aOOyt
	wnNu/LLgxfofasOaTEp76NBSGElHoYW2m7nyM4gmO/+h6g76XIJ+qrliISOZ/nNlOqpldB
	UxcXHK4+tubVdLxKT0Ljl7BE5NlL1agY7XeAz+PAG349kz+jPi2uiLIL+eudxqsXNGjRhx
	YImz62Zf/tpAQj8yp74GyqxI5r/DKCHbgvvkvvarsfqhddiyr8RyJDP0iXY9In8NENZbUY
	LNkQeAtsmR9TWZPShw+//j+bdRC8bdiSOVID/WmVdMbF0nYSZ1ObKnQIIZgr8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769067584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaS6uqL/kbrq2eJPLq2hkMyWIvEZct5vh85RpG7ja6c=;
	b=XNkNYCf87OqXQNFWIPr+ANXF/oCpu2dY6c/zA10YviunsCFAr8nk0kITlxtflLa5uTBtbY
	GZzVqyKZhN8vjEBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 12/14] bits: move the defitions of BIT() and
 BIT_ULL() back to linux/bits.h
Message-ID: <20260122082822-f25acbd0-6f7b-41a6-92a1-0873f967ca18@linutronix.de>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-13-david.laight.linux@gmail.com>
 <20260121160912-cafca67d-bfc0-414a-adaa-80c863acd93a@linutronix.de>
 <20260121192451.415f1920@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121192451.415f1920@pumpkin>

On Wed, Jan 21, 2026 at 07:24:51PM +0000, David Laight wrote:
> On Wed, 21 Jan 2026 16:17:18 +0100
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> wrote:
> 
> > On Wed, Jan 21, 2026 at 02:57:29PM +0000, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > The definition of BIT() was moved from linux/bits.h to vdso/bits.h to
> > > isolate the vdso from 'normal' kernel headers.
> > > BIT_ULL() was then moved to be defined in the same place for consistency.
> > > 
> > > Since then linux/bits.h had gained BIT_Unn() and it really makes sense
> > > for BIT() and BIT_ULL() to be defined in the same place.
> > > 
> > > Move BIT_ULL() and make code that include both headers use the definition
> > > of BIT() from linux/bits.h
> > > Add BIT_U128() for completness.
> > > 
> > > This lets BIT() pick up the extra compile time checks for W=[1c] builds
> > > that detect errors like:
> > > 	long foo(void) { int x = 64; return BIT(x); }
> > > For which clang (silently) just generates a 'return' instruction.
> > > 
> > > Note that nothing the the x86-64 build relies on the definition in
> > > vdso/bits.h, linux/bits.h is always included.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > >  include/linux/bits.h | 7 ++++++-
> > >  include/vdso/bits.h  | 2 +-
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > index 0f559038981d..3dd32b9eef35 100644
> > > --- a/include/linux/bits.h
> > > +++ b/include/linux/bits.h
> > > @@ -2,7 +2,6 @@
> > >  #ifndef __LINUX_BITS_H
> > >  #define __LINUX_BITS_H
> > >  
> > > -#include <vdso/bits.h>
> > >  #include <uapi/linux/bits.h>
> > >  
> > >  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
> > > @@ -89,10 +88,16 @@ int BIT_INPUT_CHECK_FAIL(void) __compiletime_error("Bit number out of range");
> > >  	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
> > >  #endif /* defined(__ASSEMBLY__) */
> > >  
> > > +/* Prefer this definition of BIT() to the one in vdso/bits.h */
> > > +#undef BIT
> > > +#define __VDSO_BITS_H  
> > 
> > This is ugly.
> 
> It works :-)
> I could have put an #ifndef BIT in vdso/bits.h instead.

The #ifndef in vdso/bits.h is not much better IMO.
Given that there a multiple nicer options why not use on of those?

> > Why can't the vDSO code make use of those checks, too?
> > Or use _BITUL() from the UAPI in the vDSO and remove vdso/bits.h.
> 
> I didn't actually find anything that just needed vdso/bits.h
> linux/bits.h would get included - eg (IIRC) because of warn_on_once().

That is a bug. The vdso code should only include the vdso/ namespace.
Right now the inclusions are all over the place. I'd like to clean that
up at some point.

> I'm not that sure why it got separated, it isn't as though it defines
> anything that is code version specific.

I don't understand "code version specific".

There are various issues with including normal kernel headers from the vDSO.
Symbols defined in terms of kconfig options, like BITS_PER_LONG using
CONFIG_64BIT are wrong in a compat vDSO.

> > > +#define BIT(nr)		BIT_TYPE(unsigned long, nr)
> > > +#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)
> > >  #define BIT_U8(nr)	BIT_TYPE(u8, nr)
> > >  #define BIT_U16(nr)	BIT_TYPE(u16, nr)
> > >  #define BIT_U32(nr)	BIT_TYPE(u32, nr)
> > >  #define BIT_U64(nr)	BIT_TYPE(u64, nr)
> > > +#define BIT_U128(nr)	BIT_TYPE(u128, nr)
> > >  
> > >  #if defined(__ASSEMBLY__)
> > >  
> > > diff --git a/include/vdso/bits.h b/include/vdso/bits.h
> > > index 388b212088ea..a6ac1e6b637c 100644
> > > --- a/include/vdso/bits.h
> > > +++ b/include/vdso/bits.h
> > > @@ -4,7 +4,7 @@  
> > >  >  #include <vdso/const.h>  
> > >  
> > > +/* Most code picks up BIT() from linux/bits.h */
> > >  #define BIT(nr)			(UL(1) << (nr))
> > > -#define BIT_ULL(nr)		(ULL(1) << (nr))
> > >  
> > >  #endif	/* __VDSO_BITS_H */
> > > -- 
> > > 2.39.5
> > >   
> 

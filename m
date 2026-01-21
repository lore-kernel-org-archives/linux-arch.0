Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38A425CF7;
	Wed, 21 Jan 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008642; cv=none; b=Lg0Vf5OqizWNCaxmT+4wEFB70UfDhzk4WN4X3pIK+0ybb8ltRmn89GCLQObQ2A5PfnZ0pziktdz6v410AvAmd0Ga3n+zweCuXhO7fH/0DX8liG5dFgQKnlO+MubKZhxBT1VO3abjmGOBoWKt/pUDIAI/mS+X+3upQ++I9n95z0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008642; c=relaxed/simple;
	bh=Qg6w4OVSreD2AIKSV9AIgAKktndpxrPtuvgkmk8diGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWI/R/frXZhW2hjNFlMYMvXNj5l/6nLbfHTd3rxNsfHC8IkaD+n/SIKoVPNHE/1ESFHNW9+kqNNipml0GcqJQqwKKeuVKfNnB3n4vjA+AvyuM5Ifc7/NPoSC++mnj2DnqoIcLJXNPFsnMr7b6P7eh6QIGjzdkYrhKKe04ll/uCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zn11SwTx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhK2zk3w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zn11SwTx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhK2zk3w"
Date: Wed, 21 Jan 2026 16:17:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769008639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpD1oY6H4Z9JLEfU3gatE0wEruTfdDl56dLhid56PyE=;
	b=zn11SwTxAG+I2No5pd10CRrHG9zHkNKFg6QDP0HekSetRc/aZZruAN0SlCcxoY+SNTEdcC
	1yXgrVp0nfu3TFPhGzC5ektzTu5/dx8U8lWW14eR8ZgaDKz2sHQ78y0urpa64q3nQHELkm
	wFkYEg4zjlmqX3kfjTTphI1mMclV9jBQSSwHU70DWdFIhaN7MTpmaV8MI9HSF/TBaMh8DU
	ggjjiWWqQN+sVcCauOKroKFljUBZqWnSsqqX4MvIl2WU9Dp/jf99Rjbb5ohNTiq226zavv
	QtkcXiXv4DQ44Ka+qMElvKyaPPJHqrCQhAG238gtr9QNycD0eUbfm1ROqavjlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769008639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpD1oY6H4Z9JLEfU3gatE0wEruTfdDl56dLhid56PyE=;
	b=PhK2zk3wsiSFvr3ocXjEOAoUr/JAx5XoUnxq49scIaQ7jtlQtJ5ZUSm6d2STuo98meFFva
	UUC2F0ySqwgF4xBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: david.laight.linux@gmail.com
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
Message-ID: <20260121160912-cafca67d-bfc0-414a-adaa-80c863acd93a@linutronix.de>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-13-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-13-david.laight.linux@gmail.com>

On Wed, Jan 21, 2026 at 02:57:29PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The definition of BIT() was moved from linux/bits.h to vdso/bits.h to
> isolate the vdso from 'normal' kernel headers.
> BIT_ULL() was then moved to be defined in the same place for consistency.
> 
> Since then linux/bits.h had gained BIT_Unn() and it really makes sense
> for BIT() and BIT_ULL() to be defined in the same place.
> 
> Move BIT_ULL() and make code that include both headers use the definition
> of BIT() from linux/bits.h
> Add BIT_U128() for completness.
> 
> This lets BIT() pick up the extra compile time checks for W=[1c] builds
> that detect errors like:
> 	long foo(void) { int x = 64; return BIT(x); }
> For which clang (silently) just generates a 'return' instruction.
> 
> Note that nothing the the x86-64 build relies on the definition in
> vdso/bits.h, linux/bits.h is always included.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  include/linux/bits.h | 7 ++++++-
>  include/vdso/bits.h  | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 0f559038981d..3dd32b9eef35 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -2,7 +2,6 @@
>  #ifndef __LINUX_BITS_H
>  #define __LINUX_BITS_H
>  
> -#include <vdso/bits.h>
>  #include <uapi/linux/bits.h>
>  
>  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
> @@ -89,10 +88,16 @@ int BIT_INPUT_CHECK_FAIL(void) __compiletime_error("Bit number out of range");
>  	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
>  #endif /* defined(__ASSEMBLY__) */
>  
> +/* Prefer this definition of BIT() to the one in vdso/bits.h */
> +#undef BIT
> +#define __VDSO_BITS_H

This is ugly.

Why can't the vDSO code make use of those checks, too?
Or use _BITUL() from the UAPI in the vDSO and remove vdso/bits.h.

> +#define BIT(nr)		BIT_TYPE(unsigned long, nr)
> +#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)
>  #define BIT_U8(nr)	BIT_TYPE(u8, nr)
>  #define BIT_U16(nr)	BIT_TYPE(u16, nr)
>  #define BIT_U32(nr)	BIT_TYPE(u32, nr)
>  #define BIT_U64(nr)	BIT_TYPE(u64, nr)
> +#define BIT_U128(nr)	BIT_TYPE(u128, nr)
>  
>  #if defined(__ASSEMBLY__)
>  
> diff --git a/include/vdso/bits.h b/include/vdso/bits.h
> index 388b212088ea..a6ac1e6b637c 100644
> --- a/include/vdso/bits.h
> +++ b/include/vdso/bits.h
> @@ -4,7 +4,7 @@
>  >  #include <vdso/const.h>
>  
> +/* Most code picks up BIT() from linux/bits.h */
>  #define BIT(nr)			(UL(1) << (nr))
> -#define BIT_ULL(nr)		(ULL(1) << (nr))
>  
>  #endif	/* __VDSO_BITS_H */
> -- 
> 2.39.5
> 

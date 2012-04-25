From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/2] math128, x86_64: Implement {mult,add}_u128 in 64bit asm
Date: Wed, 25 Apr 2012 11:02:41 -0700
Message-ID: <CALCETrWBMUzG9KYVOQxwCLqnEQjRizz5k4tQW2=emfx1t8TgvA@mail.gmail.com>
References: <20120425111552.665217867@chello.nl> <20120425112244.953956269@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48880 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab2DYSDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2012 14:03:02 -0400
Received: by pbbro12 with SMTP id ro12so1745568pbb.19
        for <linux-arch@vger.kernel.org>; Wed, 25 Apr 2012 11:03:01 -0700 (PDT)
In-Reply-To: <20120425112244.953956269@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Apr 25, 2012 at 4:15 AM, Peter Zijlstra <a.p.zijlstra@chello.nl=
> wrote:
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
> =A0arch/x86/include/asm/Kbuild =A0 =A0| =A0 =A01 -
> =A0arch/x86/include/asm/math128.h | =A0 39 ++++++++++++++++++++++++++=
+++++++++++++
> =A02 files changed, 39 insertions(+), 1 deletion(-)

> --- /dev/null
> +++ b/arch/x86/include/asm/math128.h
> @@ -0,0 +1,39 @@
> +#ifndef _ASM_MATH128_H
> +#define _ASM_MATH128_H
> +
> +#ifdef CONFIG_X86_64
> +
> +#ifdef __SIZEOF_INT128__
> +#define ARCH_HAS_INT128
> +#endif
> +
> +#ifndef ARCH_HAS_INT128
> +
> +static inline mul_u64_u64(u64 a, u64 b)

I think you're missing a return type and a 't'.

> +{
> + =A0 =A0 =A0 u128 res;
> +
> + =A0 =A0 =A0 asm("mulq %2"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "=3Da" (res.lo), "=3Dd" (res.hi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : =A0"rm" (b), "0" (a));
> +
> + =A0 =A0 =A0 return res;
> +}
> +#define mult_u64_u64 mult_u64_u64
> +
> +static inline add_u128(u128 a, u128 b)

Return type here, too.


--Andy

From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH] asm-generic: cmpxchg: avoid warnings from macro-ized
 cmpxchg() implementations
Date: Thu, 1 Oct 2015 22:06:53 +0800
Message-ID: <CAFiDJ59-pOvaayPBexsP7nJFMFOzY7h2m_e0UG8t9T4NO4K=2Q@mail.gmail.com>
References: <1442637741-10807-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:35196 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593AbbJAOGz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2015 10:06:55 -0400
In-Reply-To: <1442637741-10807-1-git-send-email-marex@denx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On Sat, Sep 19, 2015 at 12:42 PM, Marek Vasut <marex@denx.de> wrote:
> This change is similar to e001bbae7147b111fe1aa42beaf835635f3c016e
> ARM: cmpxchg: avoid warnings from macro-ized cmpxchg() implementations
>
> A recent change in kernel/acct.c added a new warning for many
> configurations using generic __xchg() implementation:
>
> In file included from ./arch/nios2/include/asm/cmpxchg.h:12:0,
>                  from include/asm-generic/atomic.h:18,
>                  from arch/nios2/include/generated/asm/atomic.h:1,
>                  from include/linux/atomic.h:4,
>                  from include/linux/spinlock.h:406,
>                  from include/linux/mmzone.h:7,
>                  from include/linux/gfp.h:5,
>                  from include/linux/mm.h:9,
>                  from kernel/acct.c:46:
> kernel/acct.c: In function 'acct_pin_kill':
> include/asm-generic/cmpxchg.h:94:3: warning: value computed is not used [-Wunused-value]
>   ((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
>    ^
> include/asm-generic/cmpxchg.h:102:28: note: in expansion of macro 'cmpxchg_local'
>  #define cmpxchg(ptr, o, n) cmpxchg_local((ptr), (o), (n))
>                             ^
> kernel/acct.c:177:2: note: in expansion of macro 'cmpxchg'
>   cmpxchg(&acct->ns->bacct, pin, NULL);
>   ^
>
> The code is in fact correct, it's just a cmpxchg() call that
> intentionally ignores the result, and no other code does that.  The
> warning does not show up on x86 because of the way that its cmpxchg()
> macro is written. This changes the asm-ggeneric implementation to use
> a similar construct with a compound expression instead of a typecast,
> which causes the compiler to not complain about an unused result.
>
> Fix the other macros in this file in a similar way, and place them
> just below their function implementations.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Tested with arch/nios2.

Regards
Ley Foon

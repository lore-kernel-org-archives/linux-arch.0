From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] asm-generic: cmpxchg: avoid warnings from macro-ized cmpxchg() implementations
Date: Thu, 15 Oct 2015 16:25:56 +0200
Message-ID: <201510151625.56383.marex@denx.de>
References: <1442637741-10807-1-git-send-email-marex@denx.de> <50122244.xQZES6VAKE@wuerfel>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51970 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbJOO3S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2015 10:29:18 -0400
In-Reply-To: <50122244.xQZES6VAKE@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, lftan@altera.com, linux-arch@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Wednesday, October 14, 2015 at 05:01:45 PM, Arnd Bergmann wrote:
> On Saturday 19 September 2015 06:42:21 Marek Vasut wrote:
> > This change is similar to e001bbae7147b111fe1aa42beaf835635f3c016e
> > ARM: cmpxchg: avoid warnings from macro-ized cmpxchg() implementations
> > 
> > A recent change in kernel/acct.c added a new warning for many
> > configurations using generic __xchg() implementation:
> > 
> > In file included from ./arch/nios2/include/asm/cmpxchg.h:12:0,
> > 
> >                  from include/asm-generic/atomic.h:18,
> >                  from arch/nios2/include/generated/asm/atomic.h:1,
> >                  from include/linux/atomic.h:4,
> >                  from include/linux/spinlock.h:406,
> >                  from include/linux/mmzone.h:7,
> >                  from include/linux/gfp.h:5,
> >                  from include/linux/mm.h:9,
> > 
> >                  from kernel/acct.c:46:
> > kernel/acct.c: In function 'acct_pin_kill':
> > include/asm-generic/cmpxchg.h:94:3: warning: value computed is not used
> > [-Wunused-value]
> > 
> >   ((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned
> >   long)(o),\
> >   
> >    ^
> > 
> > include/asm-generic/cmpxchg.h:102:28: note: in expansion of macro
> > 'cmpxchg_local'
> > 
> >  #define cmpxchg(ptr, o, n) cmpxchg_local((ptr), (o), (n))
> >  
> >                             ^
> > 
> > kernel/acct.c:177:2: note: in expansion of macro 'cmpxchg'
> > 
> >   cmpxchg(&acct->ns->bacct, pin, NULL);
> >   ^
> > 
> > The code is in fact correct, it's just a cmpxchg() call that
> > intentionally ignores the result, and no other code does that.  The
> > warning does not show up on x86 because of the way that its cmpxchg()
> > macro is written. This changes the asm-ggeneric implementation to use
> > a similar construct with a compound expression instead of a typecast,
> > which causes the compiler to not complain about an unused result.
> > 
> > Fix the other macros in this file in a similar way, and place them
> > just below their function implementations.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Applied to my asm-generic tree, thanks!

Thank you!

Now I really hope someone doesn't flame me to a crisp for breaking some odd
architecture ;-)

Best regards,
Marek Vasut

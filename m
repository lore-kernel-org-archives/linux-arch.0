From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/8] Allow inlined spinlocks again V5
Date: Sat, 29 Aug 2009 16:13:54 +0200
Message-ID: <20090829141354.GA29896@elte.hu>
References: <20090829102115.638224800@de.ibm.com> <20090829111642.GA17951@elte.hu> <20090829135906.GA11215@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:32992 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbZH2OOR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Aug 2009 10:14:17 -0400
Content-Disposition: inline
In-Reply-To: <20090829135906.GA11215@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> I assume you're talking of spin_unlock() and not spin_lock()?

yeah.

> It still gets inlined (spinlock.h):
> 
> /*
>  * We inline the unlock functions in the nondebug case:
>  */
> #if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
> 	!defined(CONFIG_SMP)
> # define spin_unlock(lock)              _spin_unlock(lock)
> [...]
> #else
> # define spin_unlock(lock) \
> 	do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
> [...]
> 
> Or in other words, specifying __spin_lock_is_small causes only 
> that the out-of-line variant doesn't get generated anymore. It 
> gets inlined regardless (if config options allow).
> 
> Now this could be simplified/cleanup by doing something like this:
> 
> /*
>  * We inline the unlock functions in the nondebug case:
>  */
> #if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
> 	!defined(CONFIG_SMP)
> # define spin_unlock(lock)              _spin_unlock(lock)
> [...]
> #else
> # define spin_unlock(lock) \
> 	do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
> [...]
> 
> However it sucks a bit that we have two different ways to force 
> inlining. So we could and probably should simplify this. The patch 
> below (untested) would do that:
> 
> ---
>  include/linux/spinlock.h         |   46 +++++----------------------------------
>  include/linux/spinlock_api_smp.h |   12 ++++++++++
>  2 files changed, 18 insertions(+), 40 deletions(-)

Yes, that's exactly what i was thinking of. That way your patchset 
becomes a cleanup as well, not just a 'touch a lot of dangerous 
code' excercise in masochism ;-)

A third question would be, now that we have this flexible method to 
inline/uninline locking APIs, mind checking say a 64-bit x86 
defconfig and see whether that generic set of inline/noinline 
decisions actually results in the smallest possible kernel image 
size?

I.e. we could use this opportunity to re-tune the generic defaults. 
(and thus your patch-set would become an improvement as well.)

	Ingo

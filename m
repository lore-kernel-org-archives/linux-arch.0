From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/8] Allow inlined spinlocks again V5
Date: Sat, 29 Aug 2009 13:16:42 +0200
Message-ID: <20090829111642.GA17951@elte.hu>
References: <20090829102115.638224800@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:48436 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbZH2LRL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Aug 2009 07:17:11 -0400
Content-Disposition: inline
In-Reply-To: <20090829102115.638224800@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> This patch set allows to have inlined spinlocks again.
> 
> V2: rewritten from scratch - now also with readable code
> 
> V3: removed macro to generate out-of-line spinlock variants since that
>     would break ctags. As requested by Arnd Bergmann.
> 
> V4: allow architectures to specify for each lock/unlock variant if
>     it should be kept out-of-line or inlined.
> 
> V5: simplify ifdefs as pointed out by Linus. Fix architecture compile
>     breakages caused by this change.
> 
> Linus, Ingo, do you still have objections?

Ok, this looks pretty clean.

Two small comments. One (small) worry is that the configuration 
space of this construct:

+#define __spin_lock_is_small
+#define __read_lock_is_small
+#define __write_lock_is_small
+#define __spin_lock_bh_is_small
+#define __read_lock_bh_is_small
+#define __write_lock_bh_is_small
+#define __spin_lock_irq_is_small
+#define __read_lock_irq_is_small
+#define __write_lock_irq_is_small
+#define __spin_lock_irqsave_is_small
+#define __read_lock_irqsave_is_small
+#define __write_lock_irqsave_is_small
+#define __spin_trylock_is_small
+#define __read_trylock_is_small
+#define __write_trylock_is_small
+#define __spin_trylock_bh_is_small
+#define __spin_unlock_is_small
+#define __read_unlock_is_small
+#define __write_unlock_is_small
+#define __spin_unlock_bh_is_small
+#define __read_unlock_bh_is_small
+#define __write_unlock_bh_is_small
+#define __spin_unlock_irq_is_small
+#define __read_unlock_irq_is_small
+#define __write_unlock_irq_is_small
+#define __spin_unlock_irqrestore_is_small
+#define __read_unlock_irqrestore_is_small
+#define __write_unlock_irqrestore_is_small

Is 2^28.

Could we perhaps shape this in a form that makes it 'formally' a 
manually tuned inlining decision - where we already accept such kind 
of per function decisions and know how to handle them?

I.e. rename it to something like:

  #define __always_inline__write_unlock_irqrestore

That way it fits into our existing forced-inlining attributes 
(visually and name-space wise), which means the addition of 'inline' 
or '__forced_inline', or the removal of such attributes.

The closer such a special hack is to already existing principles, 
the better we'll be able to maintain it as the years progress.

The other comment i have: you dont seem to have preserved the 
current auto-inlining of spin_lock() we did before, have you? 
Without that this patchset causes a (small) performance regression 
on every architectures but s390.

	Ingo

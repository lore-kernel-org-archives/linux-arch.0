From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 23:18:24 +0200
Message-ID: <20090816211824.GA32652@elte.hu>
References: <20090814125801.881618121@de.ibm.com> <20090814125857.181021997@de.ibm.com> <20090816175750.GA5808@osiris.boeblingen.de.ibm.com> <20090816180631.GA23448@elte.hu> <alpine.LFD.2.01.0908161123250.3162@localhost.localdomain> <20090816202431.GA27764@elte.hu> <alpine.LFD.2.01.0908161406060.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:33917 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbZHPVSf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 17:18:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908161406060.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 16 Aug 2009, Ingo Molnar wrote:
> > 
> > We do that already for that reason:
> 
> Ahh, we do. I was mislead by the fact that we still generate the 
> out-of-line ones, even though we don't use them. Which is fine, of 
> course.
> 
> It doesn't do the irqrestore versions, but that's probably not a 
> big deal.

i remember having done gradual builds and turning the inlining of 
various locking functions on/off to see how it impacts the text 
size, so we were quite close to the optimal setup ... then. (two 
years ago?)

But ... the fact that you didnt notice it shows that the inlining 
decisions in spinlock.h are less than transparent and not really 
cleanly done.

Even if we dont change a thing on the x86 side the s390 observations 
are obviously valid, and Heiko's generalization looks more 
maintainable in terms of tweakability, as it's per function granular 
and per arch as well.

OTOH, it needs some work: the CONFIG_PREEMPT and 
CONFIG_DEBUG_SPINLOCKS dependency should be expressed too - and i 
think CONFIG_PREEMPT is probably was bit s390.

And at that point we've got 2^3 * 2^28 * 20 
(configs*functions*archs) variants, and i feel a bit uneasy about 
that kind of complexity (even if the typical cases will be much 
simpler than that). We wont really get it fully right, we'll just 
drown in that.

Dammit, why cannot the compiler get this right, working it around in 
the kernel source makes things so ugly :-(

It's not rocket science to do a good inliner but IMO GCC messed 
their design up on day one by separating the assembler from the C 
compiler, hence their inliner cannot really know about how large 
instructions are. Rather stupid IMHO.

	Ingo

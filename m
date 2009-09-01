From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/8] Allow inlined spinlocks again V5
Date: Tue, 1 Sep 2009 15:19:34 +0200
Message-ID: <20090901131934.GA1726@elte.hu>
References: <20090829102115.638224800@de.ibm.com> <20090829111642.GA17951@elte.hu> <20090829135906.GA11215@osiris.boeblingen.de.ibm.com> <20090829141354.GA29896@elte.hu> <20090831085911.GA10144@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:42660 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbZIANUB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Sep 2009 09:20:01 -0400
Content-Disposition: inline
In-Reply-To: <20090831085911.GA10144@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Sat, Aug 29, 2009 at 04:13:54PM +0200, Ingo Molnar wrote:
>
> > A third question would be, now that we have this flexible method 
> > to inline/uninline locking APIs, mind checking say a 64-bit x86 
> > defconfig and see whether that generic set of inline/noinline 
> > decisions actually results in the smallest possible kernel image 
> > size?
> > 
> > I.e. we could use this opportunity to re-tune the generic 
> > defaults. (and thus your patch-set would become an improvement 
> > as well.)
> 
> Considering the large x86 user base I have no doubts that you will 
> easily find volunteers who will be happy to do this :)

Hey, you are turning my own argument against me - that's not fair 
;-)

Anyway, your latest bits make testing of it rather straightforward 
for anyone interested in fine-tuning the defaults (28 kernel builds 
ought to settle the issue), and the current inlining rules should be 
rather close to the optimal solution already.

	Ingo

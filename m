From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/9] Allow inlined spinlocks again V6
Date: Mon, 31 Aug 2009 17:56:03 +0200
Message-ID: <20090831155603.GA29986@elte.hu>
References: <20090831124330.014480226@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:34831 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbZHaP42 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 31 Aug 2009 11:56:28 -0400
Content-Disposition: inline
In-Reply-To: <20090831124330.014480226@de.ibm.com>
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
> V6: rename __spin_lock_is_small to __always_inline__spin_lock as requested
>     by Ingo Molnar. That way it is more consistent with the other methods
>     used to force inlining.
>     Also simplify inlining by getting rid of the old variants to force
>     inlining of the unlock functions.
> 
> This is hopefully the final version. I did again run the whole 
> cross compiles. The patch set applies on top of latest Linus' git 
> tree, but also applies on top of linux-next.
> 
> Ingo, I assume you don't have further objections?

Yeah, looks pretty good now.

> Should this go in via -mm then?

Well, we generally do locking API changes via the locking tree.
I'll apply them and give it some testing to see whether there's
any problems with this.

	Ingo

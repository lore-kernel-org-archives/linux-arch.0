From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in
 qrwlock.c
Date: Wed, 3 May 2017 23:32:09 +0300
Message-ID: <20170503203209.ilcifmyqxkv2igq3@yury-N73SV>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-2-ynorov@caviumnetworks.com>
 <CAMuHMdXks7pXcg+MNvqYyRWHf-WUrNWLrG8GcPWy8ho49Wx7ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0082.outbound.protection.outlook.com ([104.47.33.82]:10011
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754030AbdECUcS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 May 2017 16:32:18 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXks7pXcg+MNvqYyRWHf-WUrNWLrG8GcPWy8ho49Wx7ug@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

On Wed, May 03, 2017 at 05:05:29PM +0200, Geert Uytterhoeven wrote:
> On Wed, May 3, 2017 at 4:51 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > --- a/kernel/locking/qrwlock.c
> > +++ b/kernel/locking/qrwlock.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/percpu.h>
> >  #include <linux/hardirq.h>
> > +#include <asm/spinlock.h>
> 
> linux/spinlock.h?

Comment in include/linux/spinlock.h says:

 * here's the role of the various spinlock/rwlock related include
 * files:
 *
 * on SMP builds:
 *
 [...]
 *  asm/spinlock.h:       contains the arch_spin_*()/etc.  lowlevel
 *                        implementations, mostly inline assembly code
 *

This, and the fact that include/asm-generic/spinlock.h and
arch/arm64/include/asm/spinlock.h doesn't prevent the direct
inclusion means, for me, that I should include asm/spinlock.h,
because of all that I need only arch_spin_lock() and arch_spin_unlock().

Am I wrong?

Yury

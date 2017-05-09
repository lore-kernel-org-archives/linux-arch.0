From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Tue, 9 May 2017 21:48:29 +0300
Message-ID: <20170509184829.scwjixgc2kxxxku7@yury-N73SV>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-4-ynorov@caviumnetworks.com>
 <20170509044708.vvwgzhvdrqyljy6s@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:14752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752049AbdEISsn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 May 2017 14:48:43 -0400
Content-Disposition: inline
In-Reply-To: <20170509044708.vvwgzhvdrqyljy6s@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

On Tue, May 09, 2017 at 12:47:08PM +0800, Boqun Feng wrote:
> On Wed, May 03, 2017 at 05:51:41PM +0300, Yury Norov wrote:
> > From: Jan Glauber <jglauber@cavium.com>
> > 
> > Ported from x86_64 with paravirtualization support removed.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > 
> > Note. This patch removes protection from direct inclusion of
> > arch/arm64/include/asm/spinlock_types.h. It's done because
> > kernel/locking/qrwlock.c file does it thru the header
> > include/asm-generic/qrwlock_types.h. Until now the only user
> > of qrwlock.c was x86, and there's no such protection too.
> > 
> > I'm not happy to remove the protection, but if it's OK for x86,
> > it should be also OK for arm64. If not, I think we'd fix it
> > for x86, and add the protection there too.
> > 
> > Yury
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

[...]

> > +#define	queued_spin_unlock queued_spin_unlock
> > +/**
> > + * queued_spin_unlock - release a queued spinlock
> > + * @lock : Pointer to queued spinlock structure
> > + *
> > + * A smp_store_release() on the least-significant byte.
> > + */
> > +static inline void queued_spin_unlock(struct qspinlock *lock)
> > +{
> > +	smp_store_release((u8 *)lock, 0);
> 
> I think this part will cause endian issues, maybe you want something
> like what we do in queued_write_lock().
> 
> Have you tested this on an BE environment?

No. I think I have to. Thanks for the pointing it.

> 
> Regards,
> Boqun

I think it's just the issue of copying from x86, and there's no any
specific need to cast to u8* type on arm64. So the correct version of
it would be like this, I believe: smp_store_release(&lock->val).

Yury

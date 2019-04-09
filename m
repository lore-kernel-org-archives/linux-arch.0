Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38318 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDINqX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Apr 2019 09:46:23 -0400
Date: Tue, 9 Apr 2019 14:46:16 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
Message-ID: <20190409134616.GD2990@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-18-will.deacon@arm.com>
 <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
 <1554798941.svmfd0sejb.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554798941.svmfd0sejb.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Luis Chamberlain <mcgrof@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190409134616.xA5uwT2qNZWoncEu4-3JCpYlSM23TI8e8D7JqWk2xMg@z>

Hi Nick,

On Tue, Apr 09, 2019 at 07:00:52PM +1000, Nicholas Piggin wrote:
> Linus Torvalds's on April 6, 2019 1:50 am:
> > On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote:
> >>
> >> mmiowb() is now implied by spin_unlock() on architectures that require
> >> it, so there is no reason to call it from driver code. This patch was
> >> generated using coccinelle:
> >>
> >>         @mmiowb@
> >>         @@
> >>         - mmiowb();
> > 
> > So I love the patch series, and think we should just do it, but I do
> > wonder if some of the drivers involved end up relying on memory
> > ordering things (store_release -> load_aquire) and IO ordering rather
> > than using locking...
> 
> Hopefully the convention that smp_ prefix does not work for MMIO
> ordering helps there. Drivers relying on that would be broken today
> on powerpc, at least.
> 
> > Wouldn't such use now be broken on ia64 SN platforms? Do we care?
> 
> Hopefully not too much, what changed since last thread? :)
> 
> > So it might be worth noting that a lot of the mmiowb()s here weren't
> > paired with spin_unlock?
> 
> I repeat myself, but the correct change is for ia64 to #define wmb to
> mmiowb, then nothing is silently broken, nothing has to be noted, and 
> nobody has to care. The ia64/sn2 platform will run a little slower 
> that's all.

That's certainly something for the ia64 maintainers to consider, if they
care about this behaviour. I still have hope that we'll drop ia64 in the
near future :)

> But deliberately breaking sn2 I guess is implicitly acknowledging the 
> same end result that I wanted, so fine.
> 
> I think it might be an idea to remove all the mmiowb() that obviously
> come before spin_unlock in one big patch, but then submit the rest 
> individually to driver maintainers. I could do that rather than ask
> more work from Will, if he and you agree.

That's an option, I suppose, but I'd much rather just kill off mmiowb() in
one fell swoop and be done with it. I've added the following message to
the commit of the coccinelle patch so any breakage should be easily
rectified:

 | NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
 | spin_unlock(). However, pairing each mmiowb() removal in this patch
 | with the corresponding call to spin_unlock() is not at all trivial,
 | so there is a small chance that this change may regress any drivers
 | incorrectly relying on mmiowb() to order MMIO writes between CPUs using
 | lock-free synchronisation. If you've ended up bisecting to this commit,
 | you can reintroduce the mmiowb() calls using wmb() instead, which should
 | restore the old behaviour on all architectures other than some esoteric
 | ia64 systems.

That way we don't have to worry about the long tail of commits removing
undocumented, dangling barriers.

It's not like we're losing the information about where the mmiowb()s used to
be, so it should be easy to address any fallout (but I'm not really expecting
anything significant, to be honest with you).

Will

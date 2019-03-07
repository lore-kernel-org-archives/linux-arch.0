Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:33331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfCGAsB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Mar 2019 19:48:01 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
In-Reply-To: <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com> <1551575210.6lwpiqtg5k.astroid@bobo.none> <87ef7n7x9v.fsf@concordia.ellerman.id.au> <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
Date: Thu, 07 Mar 2019 11:47:53 +1100
Message-ID: <87k1hbv7ba.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190307004753.zykRFaevQjRGj6Fro50TxvvvB7WzndWdQScrvR7Fs6I@z>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Mar 4, 2019 at 2:24 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Without wading into the rest of the discussion, this does raise an
>> interesting point, ie. what about eg. rwlock's?
>>
>> They're basically equivalent to spinlocks, and so could reasonably be
>> expected to have the same behaviour.
>>
>> But we don't check the io_sync flag in arch_read/write_unlock() etc. and
>> both of those use lwsync.
>
> I think technically rwlocks should do the same thing, at least when
> they are used for exclusion.

OK.

> Because of the exclusion argument, we can presubably limit it to just
> write_unlock(), although at least in theory I guess you could have
> some "one reader does IO, then a writer comes in" situation..

It's a bit hard to grep for, but I did find one case:

static void netxen_nic_io_write_128M(struct netxen_adapter *adapter,
                void __iomem *addr, u32 data)
{
        read_lock(&adapter->ahw.crb_lock);
        writel(data, addr);
        read_unlock(&adapter->ahw.crb_lock);
}

It looks like that driver is using the rwlock to exclude cases that can
just do a readl()/writel() (readers) vs another case that has to reconfigure a
window or something, before doing readl()/writel() and then configuring
the window back. So that seems like a valid use for a rwlock.

Whether we want to penalise all read_unlock() usages with a mmiowb()
check just to support that one driver is another question.

> Perhaps more importantly, what about sleeping locks? When they
> actually *block*, they get the barrier thanks to the scheduler, but
> you can have a nice non-contended sequence that never does that.

Yeah.

The mutex unlock fast path is just:

	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) == curr)
		return true;

And because it's the "release" variant we just use lwsync, which doesn't
order MMIO. If it was just atomic_long_cmpxchg() that would work because
we use sync for those.

__up_write() uses atomic_long_sub_return_release(), so same story.

> I guess the fact that these cases have never even shown up as an issue
> means that we could just continue to ignore it.
>
> We could even give that approach some fancy name, and claim it as a
> revolutionary new programming paradigm ("ostrich programming" to go
> with "agile" and "pair programming").

Maybe. On power we have the double whammy of weaker ordering than
other arches and infinitesimal market share, which makes me worry that
there are bugs lurking that we just haven't found, it's happened before.

cheers

From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Date: Thu, 7 Mar 2019 10:13:18 +0100
Message-ID: <20190307091318.GA32477@hirez.programming.kicks-ass.net>
References: <20190301140348.25175-1-will.deacon@arm.com>
 <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none>
 <87ef7n7x9v.fsf@concordia.ellerman.id.au>
 <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
 <87k1hbv7ba.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1hbv7ba.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sour>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 07, 2019 at 11:47:53AM +1100, Michael Ellerman wrote:
> The mutex unlock fast path is just:
> 
> 	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) == curr)
> 		return true;
> 
> And because it's the "release" variant we just use lwsync, which doesn't
> order MMIO. If it was just atomic_long_cmpxchg() that would work because
> we use sync for those.
> 
> __up_write() uses atomic_long_sub_return_release(), so same story.

As does spin_unlock() of course, which is a great segway into...

  my RCsc desires :-)

If all your unlocks were to have SYNC, your locks would, aside from
ordering MMIO, also be RCsc, Win-Win :-)

There is, of course, that pesky little performance detail that keeps
getting in the way.

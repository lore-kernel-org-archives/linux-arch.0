From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/6] powerpc/64s: implement queued spinlocks and
 rwlocks
Date: Thu, 9 Jul 2020 12:33:38 +0200
Message-ID: <20200709103338.GQ597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-5-npiggin@gmail.com>
 <877dvdvvkm.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-ppc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877dvdvvkm.fsf@mpe.ellerman.id.au>
Sender: kvm-ppc-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 09, 2020 at 08:20:25PM +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> > These have shown significantly improved performance and fairness when
> > spinlock contention is moderate to high on very large systems.
> >
> >  [ Numbers hopefully forthcoming after more testing, but initial
> >    results look good ]
> 
> Would be good to have something here, even if it's preliminary.
> 
> > Thanks to the fast path, single threaded performance is not noticably
> > hurt.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/Kconfig                      | 13 ++++++++++++
> >  arch/powerpc/include/asm/Kbuild           |  2 ++
> >  arch/powerpc/include/asm/qspinlock.h      | 25 +++++++++++++++++++++++
> >  arch/powerpc/include/asm/spinlock.h       |  5 +++++
> >  arch/powerpc/include/asm/spinlock_types.h |  5 +++++
> >  arch/powerpc/lib/Makefile                 |  3 +++
> 
> >  include/asm-generic/qspinlock.h           |  2 ++
> 
> Who's ack do we need for that part?

Mine I suppose would do, as discussed earlier, it probably isn't
required anymore, but I understand the paranoia of not wanting to change
too many things at once :-)


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

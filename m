From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Date: Thu, 9 Jul 2020 13:03:03 +0200
Message-ID: <20200709110303.GS597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-ppc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874kqhvu1v.fsf@mpe.ellerman.id.au>
Sender: kvm-ppc-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 09, 2020 at 08:53:16PM +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
> >  arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
> >  arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
> >  arch/powerpc/platforms/pseries/Kconfig        |  5 ++
> >  arch/powerpc/platforms/pseries/setup.c        |  6 +-
> >  include/asm-generic/qspinlock.h               |  2 +
> 
> Another ack?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

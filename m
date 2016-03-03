From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
Date: Thu, 3 Mar 2016 13:44:50 +0100
Message-ID: <20160303124450.GB8781@gmail.com>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
 <20160303120227.GA2484@gmail.com>
 <20160303123809.GA19139@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303123809.GA19139@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, glider@google.com, lorenzo.pieralisi@arm.com, mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com
List-Id: linux-arch.vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Mar 03, 2016 at 01:02:27PM +0100, Ingo Molnar wrote:
> > 
> > * Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > Functions which the compiler has instrumented for ASAN place poison on
> > > the stack shadow upon entry and remove this poison prior to returning.
> > > 
> > > In some cases (e.g. hotplug and idle), CPUs may exit the kernel a number
> > > of levels deep in C code. If there are any instrumented functions on
> > > this critical path, these will leave portions of the idle thread stack
> > > shadow poisoned.
> > > 
> > > If a CPU returns to the kernel via a different path (e.g. a cold entry),
> > > then depending on stack frame layout subsequent calls to instrumented
> > > functions may use regions of the stack with stale poison, resulting in
> > > (spurious) KASAN splats to the console.
> > > 
> > > Contemporary GCCs always add stack shadow poisoning when ASAN is
> > > enabled, even when asked to not instrument a function [1], so we can't
> > > simply annotate functions on the critical path to avoid poisoning.
> > > 
> > > Instead, this series explicitly removes any stale poison before it can
> > > be hit. In the common hotplug case we clear the entire stack shadow in
> > > common code, before a CPU is brought online.
> > > 
> > > On architectures which perform a cold return as part of cpu idle may
> > > retain an architecture-specific amount of stack contents. To retain the
> > > poison for this retained context, the arch code must call the core KASAN
> > > code, passing a "watermark" stack pointer value beyond which shadow will
> > > be cleared. Architectures which don't perform a cold return as part of
> > > idle do not need any additional code.
> > > 
> > > This is a combination of previous approaches [2,3], attempting to keep
> > > as much as possible generic.
> > > 
> > > Thanks,
> > > Mark.
> > > 
> > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69863
> > > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409466.html
> > > [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/411850.html
> > > 
> > > Mark Rutland (3):
> > >   kasan: add functions to clear stack poison
> > >   sched/kasan: remove stale KASAN poison after hotplug
> > >   arm64: kasan: clear stale stack poison
> > > 
> > >  arch/arm64/kernel/sleep.S |  4 ++++
> > >  include/linux/kasan.h     |  6 +++++-
> > >  kernel/sched/core.c       |  3 +++
> > >  mm/kasan/kasan.c          | 20 ++++++++++++++++++++
> > >  4 files changed, 32 insertions(+), 1 deletion(-)
> > 
> > Looks good to me - via which tree would you like to see this merged upstream?
> 
> I'd prefer the arm64 tree as arm64 is (the most) affected by the issue
> in practice.
> 
> I'm happy for this to go via another tree if that's simpler; I'm not
> aware of anything that's likely to conflict in the arm64 tree.
> 
> Catalin, Andrey, Andrew, any preference?

Ok, for the scheduler bits:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

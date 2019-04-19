Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfDSWy0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Apr 2019 18:54:26 -0400
Date: Fri, 19 Apr 2019 11:07:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
Message-ID: <20190419090717.GN7905@worktop.programming.kicks-ass.net>
References: <20190418084119.056416939@linutronix.de>
 <20190418084255.652003111@linutronix.de>
 <20190419071843.GM4038@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1904191031390.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904191031390.3174@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, linux-arch@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Message-ID: <20190419090717._NChbu5jLK6EUbfEM8JHT5iVfiXrPpGuOtJkMij8gzo@z>

On Fri, Apr 19, 2019 at 10:32:30AM +0200, Thomas Gleixner wrote:
> On Fri, 19 Apr 2019, Peter Zijlstra wrote:
> > On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > 
> > > +typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
> > > +                                      bool reliable);
> > 
> > > +void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> > > +		     struct task_struct *task, struct pt_regs *regs);
> > > +int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
> > > +			     struct task_struct *task);
> > 
> > This bugs me a little; ideally the _reliable() thing would not exists.
> > 
> > Thomas said that the existing __save_stack_trace_reliable() is different
> > enough for the unification to be non-trivial, but maybe Josh can help
> > out?
> > 
> > >From what I can see the biggest significant differences are:
> > 
> >  - it looks at the regs sets on the stack and for FP bails early
> >  - bails for khreads and idle (after it does all the hard work!?!)
> > 
> > The first (FP checking for exceptions) should probably be reflected in
> > consume_fn(.reliable) anyway -- although that would mean a lot of extra
> > '?' entries where there are none today.
> > 
> > And the second (KTHREAD/IDLE) is something that the generic code can
> > easily do before calling into the arch unwinder.
> 
> And looking at the powerpc version of it, that has even more interesting
> extra checks in that function.

Right, but not fundamentally different from determining @reliable I
think.

Anyway, it would be good if someone knowledgable could have a look at
this.

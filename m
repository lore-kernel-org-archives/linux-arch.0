Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35705 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLyG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 07:54:06 -0400
Date: Thu, 18 Apr 2019 13:53:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 09/29] mm/kasan: Simplify stacktrace handling
In-Reply-To: <5b77992a-52b6-807e-f77d-9cf3e648c71f@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.1904181350080.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de> <20190418084253.903603121@linutronix.de> <5b77992a-52b6-807e-f77d-9cf3e648c71f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418115326.OZ4lw7gM_adzxUmHhQasZlYEKDINMJDwXmV0lqIZURk@z>

On Thu, 18 Apr 2019, Andrey Ryabinin wrote:
> On 4/18/19 11:41 AM, Thomas Gleixner wrote:
> > Replace the indirection through struct stack_trace by using the storage
> > array based interfaces.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: kasan-dev@googlegroups.com
> > Cc: linux-mm@kvack.org
> 
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> >  
> >  static inline depot_stack_handle_t save_stack(gfp_t flags)
> >  {
> >  	unsigned long entries[KASAN_STACK_DEPTH];
> > -	struct stack_trace trace = {
> > -		.nr_entries = 0,
> > -		.entries = entries,
> > -		.max_entries = KASAN_STACK_DEPTH,
> > -		.skip = 0
> > -	};
> > +	unsigned int nr_entries;
> >  
> > -	save_stack_trace(&trace);
> > -	filter_irq_stacks(&trace);
> > -
> > -	return depot_save_stack(&trace, flags);
> > +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> > +	nr_entries = filter_irq_stacks(entries, nr_entries);
> > +	return stack_depot_save(entries, nr_entries, flags);
> 
> Suggestion for further improvement:
> 
> stack_trace_save() shouldn't unwind beyond irq entry point so we wouldn't
> need filter_irq_stacks().  Probably all call sites doesn't care about
> random stack above irq entry point, so it doesn't make sense to spend
> resources on unwinding non-irq stack from interrupt first an filtering
> out it later.

There are users which care about the full trace.

Once we have cleaned up the whole architeture side, we can add core side
filtering which allows to

   1) replace the 'skip number of entries at the beginning

   2) stop the trace when it reaches a certain point

Right now, I don't want to change any of this until the whole mess is
consolidated.

Thanks,

	tglx

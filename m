Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRL5u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 07:57:50 -0400
Date: Thu, 18 Apr 2019 13:57:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
In-Reply-To: <20190418115207.GB13304@rapoport-lnx>
Message-ID: <alpine.DEB.2.21.1904181355300.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de> <20190418084255.652003111@linutronix.de> <20190418115207.GB13304@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, linux-arch@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Message-ID: <20190418115722.9xvUjI99jLRJsboigmqLf8KlGuXGIpBjJ27-t45GjHU@z>

On Thu, 18 Apr 2019, Mike Rapoport wrote:
> On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > +/**
> > + * arch_stack_walk - Architecture specific function to walk the stack
> > +
> 
> Nit: no '*' at line beginning makes kernel-doc unhappy

Oops.

> > + * @consume_entry:	Callback which is invoked by the architecture code for
> > + *			each entry.
> > + * @cookie:		Caller supplied pointer which is handed back to
> > + *			@consume_entry
> > + * @task:		Pointer to a task struct, can be NULL
> > + * @regs:		Pointer to registers, can be NULL
> > + *
> > + * @task	@regs:
> > + * NULL		NULL	Stack trace from current
> > + * task		NULL	Stack trace from task (can be current)
> > + * NULL		regs	Stack trace starting on regs->stackpointer
> 
> This will render as a single line with 'make *docs'.
> Adding line separators makes this actually a table in the generated docs:
> 
>  * ============ ======= ============================================
>  * task		regs
>  * ============ ======= ============================================
>  * NULL		NULL	Stack trace from current
>  * task		NULL	Stack trace from task (can be current)
>  * NULL		regs	Stack trace starting on regs->stackpointer
>  * ============ ======= ============================================

Cute.

> > + * Returns number of entries stored.
> 
> Can you please s/Returns/Return:/ so that kernel-doc will recognize this as
> return section.
> 
> This is relevant for other comments below as well.

Sure.

Thanks for the free kernel doc course! :)

	tglx

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 11:43:38 -0400
Date: Thu, 18 Apr 2019 17:42:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
In-Reply-To: <20190418145201.mjzyqbmkjcghqzex@treble>
Message-ID: <alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de> <20190418084255.652003111@linutronix.de> <20190418145201.mjzyqbmkjcghqzex@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, linux-arch@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Message-ID: <20190418154255.y4Eik44ojgKTLLNkAEY1zyzVd-hxveLUatDaJGMj6Iw@z>

On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > All architectures which support stacktrace carry duplicated code and
> > do the stack storage and filtering at the architecture side.
> > 
> > Provide a consolidated interface with a callback function for consuming the
> > stack entries provided by the architecture specific stack walker. This
> > removes lots of duplicated code and allows to implement better filtering
> > than 'skip number of entries' in the future without touching any
> > architecture specific code.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-arch@vger.kernel.org
> 
> This is a step in the right direction, especially if it allows us to get
> rid of the 'skip' stuff.  But I'm not crazy about the callbacks.
> 
> Another idea I had (but never got a chance to work on) was to extend the
> x86 unwind interface to all arches.  So instead of the callbacks, each
> arch would implement something like this API:
> 
> 
> struct unwind_state state;
> 
> void unwind_start(struct unwind_state *state, struct task_struct *task,
> 		  struct pt_regs *regs, unsigned long *first_frame);
> 
> bool unwind_next_frame(struct unwind_state *state);
> 
> inline bool unwind_done(struct unwind_state *state);
> 
> 
> Not only would it avoid the callbacks (which is a nice benefit already),
> it would also allow the interfaces to be used outside of the
> stack_trace_*() interfaces.  That would come in handy in cases like the
> ftrace stack tracer code, which needs more than the stack_trace_*() API
> can give.

I surely thought about that, but after staring at all incarnations of
arch/*/stacktrace.c I just gave up.

Aside of that quite some archs already have callback based unwinders
because they use them for more than stacktracing and just have a single
implementation of that loop.

I'm fine either way. We can start with x86 and then let archs convert over
their stuff, but I wouldn't hold my breath that this will be completed in
the forseeable future.

> Of course, this may be more work than what you thought you signed up for
> ;-)

I did not sign up for anything. I tripped over that mess by accident and me
being me hated it strong enough to give it at least an initial steam blast.

Thanks,

	tglx
	

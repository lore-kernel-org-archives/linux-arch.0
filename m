Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDSWyV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Apr 2019 18:54:21 -0400
Date: Fri, 19 Apr 2019 09:02:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
Message-ID: <20190419070211.GL4038@hirez.programming.kicks-ass.net>
References: <20190418084119.056416939@linutronix.de>
 <20190418084255.652003111@linutronix.de>
 <20190418145201.mjzyqbmkjcghqzex@treble>
 <alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, linux-arch@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Message-ID: <20190419070211._41ANixINaZi9ssCPhRO-40pXW_eA52BCsoiLnpwFKo@z>

On Thu, Apr 18, 2019 at 05:42:55PM +0200, Thomas Gleixner wrote:
> On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> > Another idea I had (but never got a chance to work on) was to extend the
> > x86 unwind interface to all arches.  So instead of the callbacks, each
> > arch would implement something like this API:

> I surely thought about that, but after staring at all incarnations of
> arch/*/stacktrace.c I just gave up.
> 
> Aside of that quite some archs already have callback based unwinders
> because they use them for more than stacktracing and just have a single
> implementation of that loop.
> 
> I'm fine either way. We can start with x86 and then let archs convert over
> their stuff, but I wouldn't hold my breath that this will be completed in
> the forseeable future.

I suggested the same to Thomas early on, and I even spend the time to
convert some $random arch to the iterator interface, and while it is
indeed entirely feasible, it is _far_ more work.

The callback thing OTOH is flexible enough to do what we want to do now,
and allows converting most archs to it without too much pain (as Thomas
said, many archs are already in this form and only need minor API
adjustments), which gets us in a far better place than we are now.

And we can always go to iterators later on. But I think getting the
generic unwinder improved across all archs is a really important first
step here.

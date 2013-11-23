From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Fri, 22 Nov 2013 16:42:37 -0800
Message-ID: <CA+55aFy8kx1qaWszc9nrbUaqFu7GfTtDkpzPBeE2g2U6RZjYkA@mail.gmail.com>
References: <20131122062314.GN4138@linux.vnet.ibm.com>
	<20131122151600.GA14988@gmail.com>
	<20131122184937.GX4138@linux.vnet.ibm.com>
	<CA+55aFyKKpf-i4pQ_dhy9gic74xtCbO+U8GXU6mCtQj1ZHy05A@mail.gmail.com>
	<20131122200620.GA4138@linux.vnet.ibm.com>
	<CA+55aFz0nP1_O8jO2UkX1DmDzcBm53-fFejvz=oY=x3cGNBJSQ@mail.gmail.com>
	<20131122203738.GC4138@linux.vnet.ibm.com>
	<CA+55aFwHUuaGzW_=xEWNcyVnHT-zW8-bs6Xi=M458xM3Y1qE0w@mail.gmail.com>
	<20131122215208.GD4138@linux.vnet.ibm.com>
	<CA+55aFzS2yd-VbJB5t14mP8NZG8smB1BQaYCw3Zo19FWQL92vA@mail.gmail.com>
	<20131123002542.GF4138@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131123002542.GF4138@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 22, 2013 at 4:25 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Start with Tim Chen's most recent patches for MCS locking, the ones that
> do the lock handoff using smp_store_release() and smp_load_acquire().
> Add to that Peter Zijlstra's patch that uses PowerPC lwsync for both
> smp_store_release() and smp_load_acquire().  Run the resulting lock
> at high contention, so that all lock handoffs are done via the queue.
> Then you will have something that acts like a lock from the viewpoint
> of CPU holding that lock, but which does -not- guarantee that an
> unlock+lock acts like a full memory barrier if the unlock and lock run
> on two different CPUs, and if the observer is running on a third CPU.

Umm. If the unlock and the lock run on different CPU's, then the lock
handoff cannot be done through the queue (I assume that what you mean
by "queue" is the write buffer).

And yes, the write buffer is why running unlock+lock on the *same* CPU
is a special case and can generate more re-ordering than is visible
externally (and I generally do agree that we should strive for
serialization at that point), but even it does not actually violate
the rules mentioned in Documentation/memory-barriers.txt wrt an
external CPU because the write that releases the lock isn't actually
visible at that point in the cache, and if the same CPU re-aquires it
by doing a read that bypasses the write and hits in the write buffer
or the unlock, the unlocked state in between won't even be seen
outside of that CPU.

See? The local write buffer is special. It very much bypasses the
cache, but the thing about it is that it's local to that CPU.

Now, I do have to admit that cache coherency protocols are really
subtle, and there may be something else I'm missing, but the thing you
brought up is not one of those things, afaik.

              Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Fri, 22 Nov 2013 12:06:20 -0800
Message-ID: <20131122200620.GA4138@linux.vnet.ibm.com>
References: <20131121045333.GO4138@linux.vnet.ibm.com>
 <CA+55aFyXzDUss55SjQBy+C-neRZbVsmVRR4aat+wiWfuSQJxaQ@mail.gmail.com>
 <20131121225208.GJ4138@linux.vnet.ibm.com>
 <CA+55aFx3FSGAtdSTYmsZ8xtdpiSBM-XPSnxnMpRQY+S_v_72-g@mail.gmail.com>
 <20131122040856.GK4138@linux.vnet.ibm.com>
 <CA+55aFxSL96G_uuPSbJaXfGh7DpYZ1g0NcVfPKOFg1O0o0fyZg@mail.gmail.com>
 <20131122062314.GN4138@linux.vnet.ibm.com>
 <20131122151600.GA14988@gmail.com>
 <20131122184937.GX4138@linux.vnet.ibm.com>
 <CA+55aFyKKpf-i4pQ_dhy9gic74xtCbO+U8GXU6mCtQj1ZHy05A@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyKKpf-i4pQ_dhy9gic74xtCbO+U8GXU6mCtQj1ZHy05A@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@h>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 22, 2013 at 11:06:41AM -0800, Linus Torvalds wrote:
> On Fri, Nov 22, 2013 at 10:49 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > You see, my problem is not the "crazy ordering" DEC Alpha, Itanium,
> > PowerPC, or even ARM.  It is really obvious what instructions to use in
> > a stiffened-up smp_store_release() for those guys: "mb" for DEC Alpha,
> > "st.rel" for Itanium, "sync" for PowerPC, and "dmb" for ARM.  Believe it
> > or not, my problem is instead with good old tightly ordered x86.
> >
> > We -could- just put an mfence into x86's smp_store_release() and
> > be done with it
> 
> Why would you bother?  The *acquire* has a memory barrier. End of
> story. On x86, it has to (since otherwise a load inside the locked
> region could be re-ordered wrt the write that takes the lock).

I am sorry, but that is not always correct.  For example, in the contended
case for Tim Chen's MCS queued locks, the x86 acquisition-side handoff
code does -not- contain any stores or memory-barrier instructions.
Here is that portion of the arch_mcs_spin_lock() code, along with the
x86 definition for smp_load_acquire:

+       while (!(smp_load_acquire(&node->locked)))                      \
+               arch_mutex_cpu_relax();                                 \

+#define smp_load_acquire(p)                                            \
+({                                                                     \
+       typeof(*p) ___p1 = ACCESS_ONCE(*p);                             \
+       compiletime_assert_atomic_type(*p);                             \
+       barrier();                                                      \
+       ___p1;                                                          \
+})

No stores, no memory-barrier instructions.

Of course, the fact that there are no stores means that on x86 the
critical section cannot leak out, even with no memory barrier.  That is
the easy part.  The hard part is if we want unlock+lock to be a full
memory barrier for MCS lock from the viewpoint of code not holding
that lock.  We clearly cannot rely on the non-existent memory barrier
in the acquisition handoff code.

And yes, there is a full barrier implied by the xchg() further up in
arch_mcs_spin_lock(), shown in full below, but that barrier is before
the handoff code, so that xchg() cannot have any effect on the handoff.
That xchg() therefore cannot force unlock+lock to act as a full memory
barrier in the contended queue-handoff case.

> Basically, any time you think you need to add a memory barrier on x86,
> you should go "I'm doing something wrong". It's that simple.

It -appears- that the MCS queue handoff code is one of the many cases
where we don't need a memory barrier on x86, even if we do want MCS
unlock+lock to be a full memory barrier.  But I wouldn't call it simple.
I -think- we do have a proof, but I don't yet totally trust it.

							Thanx, Paul


>                   Linus

------------------------------------------------------------------------

+#define arch_mcs_spin_lock(lock, node)                                 \
+{                                                                      \
+       struct mcs_spinlock *prev;                                      \
+                                                                       \
+       /* Init node */                                                 \
+       node->locked = 0;                                               \
+       node->next   = NULL;                                            \
+                                                                       \
+       /* xchg() provides a memory barrier */                          \
+       prev = xchg(lock, node);                                        \
+       if (likely(prev == NULL)) {                                     \
+               /* Lock acquired */                                     \
+               return;                                                 \
+       }                                                               \
+       ACCESS_ONCE(prev->next) = node;                                 \
+       /*                                                              \
+        * Wait until the lock holder passes the lock down.             \
+        * Using smp_load_acquire() provides a memory barrier that      \
+        * ensures subsequent operations happen after the lock is       \
+        * acquired.                                                    \
+        */                                                             \
+       while (!(smp_load_acquire(&node->locked)))                      \
+               arch_mutex_cpu_relax();                                 \

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

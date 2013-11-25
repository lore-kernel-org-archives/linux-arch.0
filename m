From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Mon, 25 Nov 2013 15:36:58 -0800
Message-ID: <20131125233658.GV4138@linux.vnet.ibm.com>
References: <20131121125616.GI3694@twins.programming.kicks-ass.net>
 <20131121132041.GS4138@linux.vnet.ibm.com>
 <20131121172558.GA27927@linux.vnet.ibm.com>
 <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
 <20131121221859.GH4138@linux.vnet.ibm.com>
 <20131122155835.GR3866@twins.programming.kicks-ass.net>
 <20131122182632.GW4138@linux.vnet.ibm.com>
 <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
 <20131125173540.GK3694@twins.programming.kicks-ass.net>
 <52939C5A.3070208@zytor.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <52939C5A.3070208@zytor.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>Peter Hurley <p>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 25, 2013 at 10:52:10AM -0800, H. Peter Anvin wrote:
> On 11/25/2013 09:35 AM, Peter Zijlstra wrote:
> > 
> > I think this means x86 needs help too.
> > 
> > Consider:
> > 
> > x = y = 0
> > 
> >   w[x] = 1  |  w[y] = 1
> >   mfence    |  mfence
> >   r[y] = 0  |  r[x] = 0
> > 
> > This is generally an impossible case, right? (Since if we observe y=0
> > this means that w[y]=1 has not yet happened, and therefore x=1, and
> > vice-versa).
> > 
> > Now replace one of the mfences with smp_store_release(l1);
> > smp_load_acquire(l2); such that we have a RELEASE+ACQUIRE pair that
> > _should_ form a full barrier:
> > 
> >   w[x] = 1   | w[y] = 1
> >   w[l1] = 1  | mfence
> >   r[l2] = 0  | r[x] = 0
> >   r[y] = 0   |
> > 
> > At which point we can observe the impossible, because as per the rule:
> > 
> > 'reads may be reordered with older writes to different locations'
> > 
> > Our r[y] can slip before the w[x]=1.
> 
> Yes, because although r[l2] and r[y] are ordered with respect to each
> other, they are allowed to be executed before w[x] and w[l1].  In other
> words, smp_store_release() followed by smp_load_acquire() to a different
> location do not form a full barrier.  To the *same* location, they will.

In the case where we have a single CPU doing an unlock of one lock
followed by a lock of another lock using Tim Chen's MCS lock, there
will be an xchg() that will provide the needed full barrier.

If the unlock is from one CPU and the lock is from another CPU, then
Linux kernel only requires a full barrier in the case where both
the unlock and lock are acting on the same lock variable.  Which is
the scenario under investigation.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

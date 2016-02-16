From: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: Writes, smp_wmb(), and transitivity?
Date: Tue, 16 Feb 2016 11:36:44 -0800
Message-ID: <20160216193644.GV6719@linux.vnet.ibm.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
Reply-To: paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andy.Glew-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Leonid Yegoshin <Leonid.Yegoshin-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, ppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, graham.whaley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 16, 2016 at 10:59:08AM -0800, Linus Torvalds wrote:
> On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
> <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
> >
> > Two threads:
> >
> >         int a, b;
> >
> >         void thread0(void)
> >         {
> >                 WRITE_ONCE(a, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(b, 2);
> >         }
> >
> >         void thread1(void)
> >         {
> >                 WRITE_ONCE(b, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(a, 2);
> >         }
> >
> >         /* After all threads have completed and the dust has settled... */
> >
> >         BUG_ON(a == 1 && b == 1);
> 
> So the more I look at that kind of litmus test, the less I think that
> we should care, because I can't come up with a scenario in where that
> kind of test makes sense. without even a possibility of any causal
> relationship between the two, I can't say why we'd ever care about the
> ordering of the (independent) writes to the individual variables.
> 
> If somebody can make up a causal chain, things differ. But as long as
> all the CPU's are just doing locally ordered writes, I don't think we
> need to care about a global store ordering.

Works for me!  (Yes, I can artificially generate a use case for this
thing, but all the ones I have come up with have some better and more
sane way to get the job done.  So I completely agree with your not caring
about it.)

So for transitivity, we focus on causal chains, where one task writes
to some variable that the next task reads.

In addition, if all threads use full memory barriers throughout, as in
smp_mb(), then full ordering is of course provided regardless of the
pattern of reads and writes.

							Thanx, Paul

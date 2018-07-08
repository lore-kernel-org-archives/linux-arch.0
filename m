From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Sun, 8 Jul 2018 08:39:28 +0800
Message-ID: <20180708003927.GA18424@guoren-Inspiron-7460>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180707074209.GA32147@guoren>
 <20180707195437.GA3225@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180707195437.GA3225@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jul 07, 2018 at 09:54:37PM +0200, Andrea Parri wrote:
> Hi Guo,
> 
> On Sat, Jul 07, 2018 at 03:42:10PM +0800, Guo Ren wrote:
> > On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:
> > > 	CPU0			CPU1
> > > 
> > > 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> > > 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> > > 
> > > must not allow: r1==1 && r2==0
> > CPU1 smp_store_release could be finished before WRITE_ONCE, so r1=1 &&
> > r2=0?
> 
> The emphasis is on the "must": your implementation __must__ prevent this
> from happening (say, by inserting memory barriers in smp_store_release());
> if your implementation allows the state (r1==1 && r2==0), then the imple-
> mentation is incorrect.
Ok, Got it.

> I'd suggest you have a look at the Linux-kernel memory consistency model
> documentation and the associated tools, starting with:
> 
>   Documentation/memory-barriers.txt
>   tools/memory-model/
Thx for the tips.

> (and please do not hesitate to ask questions about them, if something is
>  unclear).
I'll. Thx again.

 Guo Ren

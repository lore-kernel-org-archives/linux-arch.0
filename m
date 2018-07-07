From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Sat, 7 Jul 2018 16:08:47 +0800
Message-ID: <20180707080845.GA346@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180706121716.GO2512@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706121716.GO2512@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 06, 2018 at 02:17:16PM +0200, Peter Zijlstra wrote:
> > 
> > 	CPU0			CPU1
> > 
> > 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> > 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> > 
> > must not allow: r1==1 && r2==0
> 
> Also, since you said "SYNC.IS" is a pipeline flush, those
> instruction-sync primitives normally do not imply a store-buffer flush,
> does yours? If not it is not a valid smp_mb() implementation.
Sync.is will flush pipeline and store-buffer.

"sync"	means completion memory barrier.
"i"	means flush cpu pipeline.
"s"	means sharable to other cpus.

> 
> Notably:
> 
> 	CPU0				CPU1
> 
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(y, 1);
> 	smp_mb();			smp_mb();
> 	r0 = READ_ONCE(y);		r1 = READ_ONCE(x);
> 
> must not allow: r0==0 && r1==0
> 
> Which would be possible with a regular instruction-sync barrier, but
> must absolutely not be true with a full memory barrier.
> 
> (and you can replace the smp_mb(); r = READ_ONCE(); with r = xchg() to
> again see why you need that first smp_mb()).

	CPU0			CPU1

	WRITE_ONCE(x, 1)	WRITE_ONCE(y, 1)
	r0 = xchg(&y, 2)	r1 = xchg(&x, 2)

must not allow: r0==0 && r1==0
So we must add a smp_mb between WRITE_ONCE() and xchg(), right?

 Guo Ren

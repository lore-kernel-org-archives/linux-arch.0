From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Tue, 14 Jul 2015 12:08:11 +0100
Message-ID: <20150714110811.GE16213@arm.com>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
 <1436790687-11984-2-git-send-email-will.deacon@arm.com>
 <20150714102511.GI19282@twins.programming.kicks-ass.net>
 <20150714103220.GB16213@arm.com>
 <20150714105837.GJ19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714105837.GJ19282@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 14, 2015 at 11:58:37AM +0100, Peter Zijlstra wrote:
> On Tue, Jul 14, 2015 at 11:32:20AM +0100, Will Deacon wrote:
> > On Tue, Jul 14, 2015 at 11:25:11AM +0100, Peter Zijlstra wrote:
> > > Could we not define _{acquire,release} in terms of _relaxed and
> > > smp_mb__{after,before}_atomic() ?
> > 
> > I actually started out with that, but it penalises architectures that
> > don't have _relaxed implementations of some routines.
> 
> #ifndef atomic_add_return_relaxed
> 
> #define atomic_add_return_relaxed	atomic_add_return
> /*
>  * If one cannot define a more relaxed version,
>  * acquire/release are out the window too.
>  */
> #define  atomic_add_return_acquire	atomic_add_return
> #define  atomic_add_return_release	atomic_add_return
> 
> #else /* relaxed */
> 
> #ifndef atomic_add_return_acquire
> #define  atomic_add_return_acquire(args...)	\
> do {						\
> 	atomic_add_return_relaxed(args);	\
> 	smp_mb__after_atomic();			\
> } while (0)
> #endif
> 
> #ifndef atomic_add_return_release
> #define  atomic_add_return_release(args...)	\
> do {						\
> 	smp_mb__before_atomic();		\
> 	atomic_add_return_relaxed(args);	\
> } while (0)
> #endif
> 
> #endif /* relaxed */

If a picture is worth a thousand words, a patch is worth at least a thousand
pictures.

I'll add this for v2.

Will

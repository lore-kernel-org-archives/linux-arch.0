From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 1/8] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Mon, 27 Jul 2015 11:21:07 +0100
Message-ID: <20150727102106.GD3358@arm.com>
References: <1437746681-2809-1-git-send-email-will.deacon@arm.com>
 <1437746681-2809-2-git-send-email-will.deacon@arm.com>
 <20150727091430.GP19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150727091430.GP19282@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 27, 2015 at 10:14:30AM +0100, Peter Zijlstra wrote:
> On Fri, Jul 24, 2015 at 03:04:34PM +0100, Will Deacon wrote:
> > This patch introduces three new ordering semantics for these operations:
> > 
> >   - *_relaxed: No ordering guarantees. This is similar to what we have
> >                already for the non-return atomics (e.g. atomic_add).
> > 
> >   - *_acquire: ACQUIRE semantics, similar to smp_load_acquire.
> > 
> >   - *_release: RELEASE semantics, similar to smp_store_release.
> 
> Do we want to further specify that for the RmW operations the Read/load
> will provide the acquire and the Write/store the release?

Yeah, that's not a bad idea, but if we add that then I probably need to
re-iterate the cmpxchg strangeness since a failed cmpxchg_acquire would
still not have barrier semantics with the current implementation even though
it must have performed a Read/load access.

Will

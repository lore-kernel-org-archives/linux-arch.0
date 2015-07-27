From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 1/8] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Mon, 27 Jul 2015 17:33:00 +0100
Message-ID: <20150727163300.GL3358@arm.com>
References: <1437746681-2809-1-git-send-email-will.deacon@arm.com>
 <1437746681-2809-2-git-send-email-will.deacon@arm.com>
 <20150727091430.GP19282@twins.programming.kicks-ass.net>
 <20150727102106.GD3358@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54262 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG0Qc6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Jul 2015 12:32:58 -0400
Content-Disposition: inline
In-Reply-To: <20150727102106.GD3358@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Mon, Jul 27, 2015 at 11:21:06AM +0100, Will Deacon wrote:
> On Mon, Jul 27, 2015 at 10:14:30AM +0100, Peter Zijlstra wrote:
> > On Fri, Jul 24, 2015 at 03:04:34PM +0100, Will Deacon wrote:
> > > This patch introduces three new ordering semantics for these operations:
> > > 
> > >   - *_relaxed: No ordering guarantees. This is similar to what we have
> > >                already for the non-return atomics (e.g. atomic_add).
> > > 
> > >   - *_acquire: ACQUIRE semantics, similar to smp_load_acquire.
> > > 
> > >   - *_release: RELEASE semantics, similar to smp_store_release.
> > 
> > Do we want to further specify that for the RmW operations the Read/load
> > will provide the acquire and the Write/store the release?
> 
> Yeah, that's not a bad idea, but if we add that then I probably need to
> re-iterate the cmpxchg strangeness since a failed cmpxchg_acquire would
> still not have barrier semantics with the current implementation even though
> it must have performed a Read/load access.

Something like below?

Will

--->8

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 899b4035569e..d2515c05e7c8 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -14,6 +14,11 @@
  * - Release: Provides RELEASE semantics, _release suffix.
  * - Relaxed: No ordering guarantees, _relaxed suffix.
  *
+ * For compound atomics performing both a load and a store, ACQUIRE
+ * semantics apply only to the load and RELEASE semantics only to the
+ * store portion of the operation. Note that a failed cmpxchg_acquire
+ * does -not- imply any memory ordering constraints.
+ *
  * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
  */
 

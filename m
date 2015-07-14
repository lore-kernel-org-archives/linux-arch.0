From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Tue, 14 Jul 2015 13:24:20 +0200
Message-ID: <20150714112420.GK3644@twins.programming.kicks-ass.net>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
 <1436790687-11984-2-git-send-email-will.deacon@arm.com>
 <20150714102511.GI19282@twins.programming.kicks-ass.net>
 <20150714103220.GB16213@arm.com>
 <20150714105837.GJ19282@twins.programming.kicks-ass.net>
 <20150714110811.GE16213@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34142 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbGNLY1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 07:24:27 -0400
Content-Disposition: inline
In-Reply-To: <20150714110811.GE16213@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Tue, Jul 14, 2015 at 12:08:11PM +0100, Will Deacon wrote:
> On Tue, Jul 14, 2015 at 11:58:37AM +0100, Peter Zijlstra wrote:


> > #ifndef atomic_add_return_relaxed
> > 
> > #define atomic_add_return_relaxed	atomic_add_return
> > /*
> >  * If one cannot define a more relaxed version,
> >  * acquire/release are out the window too.
> >  */
> > #define  atomic_add_return_acquire	atomic_add_return
> > #define  atomic_add_return_release	atomic_add_return
> > 
> > #else /* relaxed */
> > 
> > #ifndef atomic_add_return_acquire
> > #define  atomic_add_return_acquire(args...)	\
> > do {						\
> > 	atomic_add_return_relaxed(args);	\
> > 	smp_mb__after_atomic();			\
> > } while (0)
> > #endif
> > 
> > #ifndef atomic_add_return_release
> > #define  atomic_add_return_release(args...)	\
> > do {						\
> > 	smp_mb__before_atomic();		\
> > 	atomic_add_return_relaxed(args);	\
> > } while (0)
> > #endif

One could even take it one step further and go:

#ifndef atomic_add_return
#define atomic_add_return(args...)		\
do {						\
	smp_mb__before_atomic();		\
	atomid_add_return_relaxed(args);	\
	smp_mb__after_atomic();			\
} while (0)

> > 
> > #endif /* relaxed */
> 
> If a picture is worth a thousand words, a patch is worth at least a thousand
> pictures.

:-)

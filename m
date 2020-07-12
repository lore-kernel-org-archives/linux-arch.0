From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder
 cpu into lock
Date: Sun, 12 Jul 2020 19:34:52 +0200
Message-ID: <20200712173452.GB10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgGLRfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 13:35:04 -0400
Content-Disposition: inline
In-Reply-To: <20200711182128.29130-3-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>

On Sat, Jul 11, 2020 at 02:21:28PM -0400, Waiman Long wrote:
> The previous patch enables native qspinlock to store lock holder cpu
> number into the lock word when the lock is acquired via the slowpath.
> Since PV qspinlock uses atomic unlock, allowing the fastpath and
> slowpath to put different values into the lock word will further slow
> down the performance. This is certainly undesirable.
> 
> The only way we can do that without too much performance impact is to
> make fastpath and slowpath put in the same value. Still there is a slight
> performance overhead in the additional access to a percpu variable in the
> fastpath as well as the less optimized x86-64 PV qspinlock unlock path.
> 
> A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
> distros to decide if they want to enable lock holder cpu information in
> the lock itself for both native and PV qspinlocks across both fastpath
> and slowpath. If this option is not configureed, only native qspinlocks
> in the slowpath will put the lock holder cpu information in the lock
> word.

And this kills it,.. if it doesn't make unconditional sense, we're not
going to do this. It's just too ugly.

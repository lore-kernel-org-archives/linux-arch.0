From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 19:11:37 +0200
Message-ID: <20171011171137.bb2evetsnk2qtdhc@hirez.programming.kicks-ass.net>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
 <20171011164748.GK3521@linux.vnet.ibm.com>
 <20171011165405.xd4xfa2x3dcz4e57@hirez.programming.kicks-ass.net>
 <20171011170631.GN3521@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51834 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdJKRLs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Oct 2017 13:11:48 -0400
Content-Disposition: inline
In-Reply-To: <20171011170631.GN3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com

On Wed, Oct 11, 2017 at 10:06:31AM -0700, Paul E. McKenney wrote:

> This, you mean?
> 
> data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));

Yep, that one. Although in my tree it now appears to look like:

        data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
                                                  cpu_of(rq)));

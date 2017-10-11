From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 10:34:23 -0700
Message-ID: <20171011173423.GO3521@linux.vnet.ibm.com>
References: <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
 <20171011164748.GK3521@linux.vnet.ibm.com>
 <20171011165405.xd4xfa2x3dcz4e57@hirez.programming.kicks-ass.net>
 <20171011170631.GN3521@linux.vnet.ibm.com>
 <20171011171137.bb2evetsnk2qtdhc@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751487AbdJKRe3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 13:34:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BHYJ4D137168
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 13:34:29 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dhnn0es5s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 13:34:28 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 13:34:27 -0400
Content-Disposition: inline
In-Reply-To: <20171011171137.bb2evetsnk2qtdhc@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com

On Wed, Oct 11, 2017 at 07:11:37PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2017 at 10:06:31AM -0700, Paul E. McKenney wrote:
> 
> > This, you mean?
> > 
> > data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
> 
> Yep, that one. Although in my tree it now appears to look like:
> 
>         data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
>                                                   cpu_of(rq)));

So in the non-RCU case, we could simply replace rcu_dereference_sched()
with ACCESS_ONCE(), right?  Thus no need to change the per-CPU
primitives.  Especially given that most uses of per-CPU variables
don't even need protection from load/store tearing, let alone
protection from Alpha.

Or am I missing something subtle here?

							Thanx, Paul

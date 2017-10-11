From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 10:14:37 -0700
Message-ID: <20171011171437.GA17681@linux.vnet.ibm.com>
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
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751532AbdJKROr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 13:14:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BHElfV083460
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 13:14:47 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dhnxecxrs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 13:14:47 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 13:14:41 -0400
Content-Disposition: inline
In-Reply-To: <20171011170631.GN3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com

On Wed, Oct 11, 2017 at 10:06:31AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 11, 2017 at 06:54:05PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 11, 2017 at 09:47:48AM -0700, Paul E. McKenney wrote:
> > > Interesting.  Do we currently have any dependencies headed by
> > > this_cpu_read()?
> > 
> > Nope, but almost, look for: cpufreq_update_util_data.
> 
> This, you mean?
> 
> data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
> 
> True, a non-RCU dependency use case would want to use ACCESS_ONCE()
> in the new regime.

Right...  s/ACCESS_ONCE()/READ_ONCE()/

							Thanx, Paul

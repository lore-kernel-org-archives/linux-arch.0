From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 17:49:24 +0200
Message-ID: <1334936964.2463.66.camel@laptop>
References: <20120420122120.097464672@linutronix.de>
	 <1334928098.2463.56.camel@laptop>  <20120420154202.GB32324@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49079 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2DTPtg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2012 11:49:36 -0400
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1SLG5X-000195-D8
	for linux-arch@vger.kernel.org; Fri, 20 Apr 2012 15:49:35 +0000
In-Reply-To: <20120420154202.GB32324@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, David Rientjes <rientjes@google.com>

On Fri, 2012-04-20 at 08:42 -0700, Tejun Heo wrote:
> I'm still leaning towards restricting kthreadd and any PF_THREAD_BOUND
> threads in the root cgroup.  

I'd definitely agree with restricting those. 

> I'm not sure about !BOUND kthreads tho.
> It doesn't make sense for the most part but there are cases
> (e.g. crypto kthreads) which might make some sense.
> 
Agreed as well. There are a few nasty corner cases with unbound
workqueues vs allowing cgroups (as how to place new worker threads
correctly etc..). Sorting that is a 'fun' next problem.

Could we merge the kthreadd/PF_THREAD_BOUND restriction? You've got my
ACK and I'm fairly sure tglx will ACK it as well.

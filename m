From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 17:56:25 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204201755580.2542@ionos>
References: <20120420122120.097464672@linutronix.de>  <1334928098.2463.56.camel@laptop>  <20120420154202.GB32324@google.com> <1334936964.2463.66.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45755 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab2DTP4c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2012 11:56:32 -0400
In-Reply-To: <1334936964.2463.66.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, David Rientjes <rientjes@google.com>

On Fri, 20 Apr 2012, Peter Zijlstra wrote:

> On Fri, 2012-04-20 at 08:42 -0700, Tejun Heo wrote:
> > I'm still leaning towards restricting kthreadd and any PF_THREAD_BOUND
> > threads in the root cgroup.  
> 
> I'd definitely agree with restricting those. 
> 
> > I'm not sure about !BOUND kthreads tho.
> > It doesn't make sense for the most part but there are cases
> > (e.g. crypto kthreads) which might make some sense.
> > 
> Agreed as well. There are a few nasty corner cases with unbound
> workqueues vs allowing cgroups (as how to place new worker threads
> correctly etc..). Sorting that is a 'fun' next problem.
> 
> Could we merge the kthreadd/PF_THREAD_BOUND restriction? You've got my
> ACK and I'm fairly sure tglx will ACK it as well.

Acked-and-appreciated-by-me

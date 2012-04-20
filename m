From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 15:21:38 +0200
Message-ID: <1334928098.2463.56.camel@laptop>
References: <20120420122120.097464672@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53345 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab2DTNVn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2012 09:21:43 -0400
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1SLDmQ-0000oY-Ik
	for linux-arch@vger.kernel.org; Fri, 20 Apr 2012 13:21:42 +0000
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1SLDmQ-0002Cp-7o
	for linux-arch@vger.kernel.org; Fri, 20 Apr 2012 13:21:42 +0000
In-Reply-To: <20120420122120.097464672@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>, David Rientjes <rientjes@google.com>

On Fri, 2012-04-20 at 13:05 +0000, Thomas Gleixner wrote:
> This first part moves the idle thread management for non-boot cpus
> into the core. fork_idle() is called in a workqueue as it is
> implemented in a few architectures already. This is necessary when not
> all cpus are brought up by the early boot code as otherwise we would
> take a ref on the user task VM of the thread which brings the cpu up
> via the sysfs interface. 

So I was thinking about this and I think we should make that kthreadd
instead of a random workqueue thread due to all that cgroup crap. People
are wanting to place all sorts of kernel threads in cgroups and I'm
still arguing that kthreadd should not be allowed in cgroups.

Tejun, what's the status of that patch? Afaict David Rientjes's use-case
is insane and mostly a side effect of memcg broken-ness.

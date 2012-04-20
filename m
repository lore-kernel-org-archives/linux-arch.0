From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 10:55:02 -0700
Message-ID: <20120420175502.GG2407@linux.vnet.ibm.com>
References: <20120420122120.097464672@linutronix.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:55932 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab2DTRzc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2012 13:55:32 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 20 Apr 2012 11:55:31 -0600
Content-Disposition: inline
In-Reply-To: <20120420122120.097464672@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On Fri, Apr 20, 2012 at 01:05:41PM -0000, Thomas Gleixner wrote:
> Dear all,
> 
> I'm working on refactoring the SMP boot and CPU hotplug implementation.
> 
> The current code has evolved over time into a conglomerate of
> warts. My main goals are to:
> 
>  - reduce the architecture code by moving repeating constructs to the
>    core
> 
>  - redesigning the handling of per cpu threads. There is no point to
>    tear down the threads just to create them again.
> 
>  - restructuring the notifier facility into a proper tree with
>    dependencies to avoid the gazillion of callbacks and moving
>    setup/teardown code into the context of the upcoming/dying cpu
> 
> The motivation behind this work is the cpu hotplug nightmare which we
> are facing in the RT kernel and the requests from several groups
> (e.g. ARM) to make hotplug more lightweight and faster.
> 
> This first part moves the idle thread management for non-boot cpus
> into the core. fork_idle() is called in a workqueue as it is
> implemented in a few architectures already. This is necessary when not
> all cpus are brought up by the early boot code as otherwise we would
> take a ref on the user task VM of the thread which brings the cpu up
> via the sysfs interface.
> 
> This converts all architectures except m32r, mn10300, tile and UM to
> the new core facility. These architecture are calling fork_idle() in
> the very early boot code in smp_prepare_cpus() for unknown reasons.
> I haven't analyzed yet, whether this is on purpose or can be moved
> over to the generic facility. It'd be nice if the responsible maintainers
> could look into that as well.

Looks good to me!  Ran some brief rcutorture+hotplug tests, and it
did fine on KVM on 32-bit x86.

							Thanx, Paul

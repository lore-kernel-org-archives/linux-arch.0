Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:39903 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233Ab3BZOj0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2013 09:39:26 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 26 Feb 2013 20:06:24 +0530
Message-ID: <512CC899.4060908@linux.vnet.ibm.com>
Date: Tue, 26 Feb 2013 20:07:13 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com> <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com> <CACvQF529c72xLuosD44CPd_y_0zJBc-tjgNQpBiD0UhbzS8XDg@mail.gmail.com>
In-Reply-To: <CACvQF529c72xLuosD44CPd_y_0zJBc-tjgNQpBiD0UhbzS8XDg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lai Jiangshan <eag0628@gmail.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com, vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20130226143713.6m6vKH_HES_DY8ehnlSshde2n_q9QJyyriDTeANCqes@z>

On 02/26/2013 07:47 PM, Lai Jiangshan wrote:
> On Mon, Feb 18, 2013 at 8:38 PM, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> Using global rwlocks as the backend for per-CPU rwlocks helps us avoid many
>> lock-ordering related problems (unlike per-cpu locks). However, global
>> rwlocks lead to unnecessary cache-line bouncing even when there are no
>> writers present, which can slow down the system needlessly.
> 
> per-CPU rwlocks(yours and mine) are the exactly same as rwlock_t in
> the view of lock dependency(except reader-C.S. can be nested in
> writer-C.S.)
> so they can deadlock in this order:
> 
> spin_lock(some_lock);				percpu_write_lock_irqsave()
> 						case CPU_DYING
> percpu_read_lock_irqsafe();	<---deadlock--->	spin_lock(some_lock);
> 

Yes, of course! But this is the most straight-forward of cases to fix,
because there are a well-defined number of CPU_DYING notifiers, and the fix
is to make the lock ordering same at both sides.

The real challenge is with cases like below:

spin_lock(some_lock)			percpu_read_lock_irqsafe()

percpu_read_lock_irqsafe()		spin_lock(some_lock)

The locking primitives (percpu_read_lock/unlock_irqsafe) have been explicitly
designed to keep cases like the above deadlock-free. Because, they ease
conversions from preempt_disable() to the new locking primitive without
lock-ordering headache.

> The lockdep can find out such dependency, but we must try our best to
> find out them before merge the patchset to mainline. We can  review
> all the code of cpu_disable() and CPU_DYING and fix this kinds of lock
> dependency, but it is not easy thing, it may be a long term project.
> 

:-)

That's exactly what I have done in this patchset, and that's why there
are 46 patches in this series! :-) I have run this patchset with lockdep
turned on, and verified that there are no locking problems due to the
conversion. I even posted out performance numbers from this patchset
(ie., in comparison to stop_machine), if you are curious...
http://article.gmane.org/gmane.linux.kernel/1435249

But yes, I'll have to re-verify this because of the new code that went in
during this merge window.

> ======
> And if there is any CPU_DYING code takes no locks and do some
> works(because they know they are called via stop_machine()) we need to
> add that locking code back if there is such code.(I don't know whether
> such code exist or not)
>

Yes, I explicitly verified this too. (I had mentioned this in the cover letter).

Regards,
Srivatsa S. Bhat


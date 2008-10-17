From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Fri, 17 Oct 2008 14:42:15 -0400
Message-ID: <20081017184215.GB9874@Krystal>
References: <20081016232729.699004293@polymtl.ca> <20081016234657.837704867@polymtl.ca> <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org> <20081017012835.GA30195@Krystal> <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com> <20081017172515.GA9639@goodmis.org> <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tomts40.bellnexxia.net ([209.226.175.97]:35801 "EHLO
	tomts40-srv.bellnexxia.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751508AbYJQSmS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Oct 2008 14:42:18 -0400
Content-Disposition: inline
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

* Luck, Tony (tony.luck@intel.com) wrote:
> > I agree that one cache line bouncer is devastating to performance. But
> > as Mathieu said, it is better than a global tracer with lots of bouncing
> > going on.
> 
> Scale up enough, and it becomes more than just a performance problem.
> When SGI first tried to boot on 512 cpus they found the kernel hung
> completely because of a single global atomic counter for how many
> interrupts there were.  With HZ=1024 and 512 cpus the ensuing cache
> line bouncing storm from each interrupt took longer to resolve than
> the interval between interrupts.
> 
> With higher event rates (1KHz seems relatively low) this wall will
> be a problem for smaller systems too.
> 

Hrm, on such systems
- *large* amount of cpus
- no synchronized TSCs

What would be the best approach to order events ? Do you think we should
consider using HPET, event though it's painfully slow ? Would it be
faster than cache-line bouncing on such large boxes ? With a frequency
around 10MHz, that would give a 100ns precision, which should be enough
to order events. However, HPET is known for its poor performances, which
I doubt will do better than the cache-line bouncing alternative.

> > ftrace does not have a global counter, but on some boxes with out of
> > sync TSCs, it could not find race conditions. I had to pull in logdev,
> > which found the race right away, because of this atomic counter.
> 
> Perhaps this needs to be optional (and run-time switchable).  Some
> users (tracking performance issues) will want the  tracer to have
> the minumum possible effect on the system.  Others (chasing race
> conditions) will want the best possible ordering of events between
> cpus[*].
> 

Yup, I think this solution would work. The user could specify the time
source for a specific set of buffers (a trace) through debugfs files.

> -Tony
> 
> [*] I'd still be concerned that a heavyweight strict ordering might
> perturb the system enough to make the race disappear when tracing
> is enabled.
> 

Yes, it's true that it may make the race disappear, but what has been
seen in the field (Steven could confirm that) is that it usually makes
the race more likely to appear due to an enlarged race window. But I
guess it all depends on where the activated instrumentation is.

Mathieu


-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

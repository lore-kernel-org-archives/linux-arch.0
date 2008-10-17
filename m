From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC patch 15/15] LTTng timestamp x86
Date: Fri, 17 Oct 2008 11:08:13 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
References: <20081016232729.699004293@polymtl.ca>
 <20081016234657.837704867@polymtl.ca>
 <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org>
 <20081017012835.GA30195@Krystal>
 <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
 <20081017172515.GA9639@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14032 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbYJQSIh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Oct 2008 14:08:37 -0400
In-Reply-To: <20081017172515.GA9639@goodmis.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

> I agree that one cache line bouncer is devastating to performance. But
> as Mathieu said, it is better than a global tracer with lots of bouncing
> going on.

Scale up enough, and it becomes more than just a performance problem.
When SGI first tried to boot on 512 cpus they found the kernel hung
completely because of a single global atomic counter for how many
interrupts there were.  With HZ=1024 and 512 cpus the ensuing cache
line bouncing storm from each interrupt took longer to resolve than
the interval between interrupts.

With higher event rates (1KHz seems relatively low) this wall will
be a problem for smaller systems too.

> ftrace does not have a global counter, but on some boxes with out of
> sync TSCs, it could not find race conditions. I had to pull in logdev,
> which found the race right away, because of this atomic counter.

Perhaps this needs to be optional (and run-time switchable).  Some
users (tracking performance issues) will want the  tracer to have
the minumum possible effect on the system.  Others (chasing race
conditions) will want the best possible ordering of events between
cpus[*].

-Tony

[*] I'd still be concerned that a heavyweight strict ordering might
perturb the system enough to make the race disappear when tracing
is enabled.

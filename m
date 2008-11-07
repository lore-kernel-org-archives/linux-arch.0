From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 07 Nov 2008 11:03:35 +0000
Message-ID: <25298.1226055815@redhat.com>
References: <alpine.LFD.2.00.0811070256450.13034@xanadu.home> <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca> <20081106220530.5b0e3a96.akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754755AbYKGLEY@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0811070256450.13034@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: dhowells@redhat.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:

> > I mean, the darned thing is called from sched_clock(), which can be
> > concurrently called on separate CPUs and which can be called from
> > interrupt context (with an arbitrary nesting level!) while it was running
> > in process context.
> 
> Yes!  And this is so on *purpose*.  Please take some time to read the 
> comment that goes along with it, and if you're still not convinced then 
> look for those explanation emails I've already posted.

I agree with Nicolas on this.  It's abominably clever, but I think he's right.

The one place I remain unconvinced is over the issue of preemption of a process
that is in the middle of cnt32_to_63(), where if the preempted process is
asleep for long enough, I think it can wind time backwards when it resumes, but
that's not a problem for the one place I want to use it (sched_clock()) because
that is (almost) always called with preemption disabled in one way or another.

The one place it isn't is a debugging case that I'm not too worried about.

> > /*
> >  * Caller must provide locking to protect *caller_state
> >  */
> 
> NO!  This is meant to be LOCK FREE!

Absolutely.

David

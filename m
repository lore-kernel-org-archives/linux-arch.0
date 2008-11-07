From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 07 Nov 2008 10:59:28 +0000
Message-ID: <25275.1226055568@redhat.com>
References: <20081106220530.5b0e3a96.akpm@linux-foundation.org> <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45898 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbYKGLAB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Nov 2008 06:00:01 -0500
In-Reply-To: <20081106220530.5b0e3a96.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dhowells@redhat.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Nicolas Pitre <nico@cam.org>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> I mean, the darned thing is called from sched_clock(), which can be
> concurrently called on separate CPUs and which can be called from
> interrupt context (with an arbitrary nesting level!) while it was running
> in process context.
> 
> Who let that thing into Linux?

Having crawled all over it, and argued with Nicolas and Panasonic about it, I
think it's safe in sched_clock(), provided sched_clock() never gets preempted -
which appears to be the case.

David

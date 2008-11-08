From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Sat, 08 Nov 2008 00:45:45 +0000
Message-ID: <9933.1226105145@redhat.com>
References: <20081108001555.GE18378@flint.arm.linux.org.uk> <20081107003816.9b0f947a.akpm@linux-foundation.org> <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca> <20081106220530.5b0e3a96.akpm@linux-foundation.org> <alpine.LFD.2.00.0811070256450.13034@xanadu.home> <25363.1226056819@redhat.com> <20081107164758.GB22134@Krystal> <20081107201118.GB28600@flint.arm.linux.org.uk> <20081107213610.GC2654@Krystal> <9405.1226101315@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47043 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYKHAqf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Nov 2008 19:46:35 -0500
In-Reply-To: <20081108001555.GE18378@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: dhowells@redhat.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> It sounds to me as if the right answer is for it to move back to being an
> ARM private thing with a MN10300 private copy, rather than it pretending
> to be something everyone can use.

The only problem I have with that is that there are then two independent
copies of it:-(

David

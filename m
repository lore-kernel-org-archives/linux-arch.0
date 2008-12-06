From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Sat, 6 Dec 2008 02:23:54 +0100
Message-ID: <18745.54314.498144.446296@harpo.it.uu.se>
References: <20081204225345.654705757@linutronix.de>
	<18744.29747.728320.652642@cargo.ozlabs.ibm.com>
	<20081205063131.GB12785@elte.hu>
	<18744.56857.259756.129894@cargo.ozlabs.ibm.com>
	<20081205080813.GA2030@elte.hu>
	<18744.61429.548462.667020@cargo.ozlabs.ibm.com>
	<20081205120734.GA26244@elte.hu>
	<18745.49593.567217.277510@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41328 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbYLFBZN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Dec 2008 20:25:13 -0500
In-Reply-To: <18745.49593.567217.277510@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

Paul Mackerras writes:
 > Furthermore, since your generic code doesn't know anything about the
 > constraints and thinks it can just add any counter to any task at any
 > time

This observation alone makes this proposal a non-starter.
Counters are not independent. Even on x86. Never have been.

If you want to fix something, here's one:
- Make the decision whether to schedule task t on processor p a
  function of what other set of tasks T are currently on processor p.

The issue is that some performance counter events aren't thread
local, e.g. Nehalem uncore stuff and similar HW crap in AMD
northbridge events and everything P4. So while one task t1
is running it's also reserving off-thread resources R, making those
resources unavailable for other tasks T.

(If you want a simpler metaphor, imagine a multi-threaded or multi-core
processor package having only a single floating-point unit. How would
you handle that in the scheduler? There are performance counter events
from both Intel and AMD that pose the same challenge.)

I "solved" that in perfctr for P4 by enforcing affinity constraints,
but surely the scheduler could be smarter?

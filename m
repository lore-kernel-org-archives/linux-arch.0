From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Sun, 15 Mar 2015 08:06:50 +1100
Message-ID: <1426367210.17565.219.camel@kernel.crashing.org>
References: <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
	 <1243872207.287578.1426193760572.JavaMail.zimbra@efficios.com>
	 <20150312211258.GX5412@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56882 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbbCNVIU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 14 Mar 2015 17:08:20 -0400
In-Reply-To: <20150312211258.GX5412@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Sullivan <sully@msully.net>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org

On Thu, 2015-03-12 at 14:12 -0700, Paul E. McKenney wrote:
> 
> Are there any architectures left that use hardware-assisted global
> TLB invalidation?  

ARM and PowerPC at least...

Cheers,
Ben.

> On such an architecture, you might not get a memory
> barrier except on the CPU executing the mprotect() or munmap().
> 
> (Here is hoping that no one does -- it is a cute abuse^Whack
> otherwise!)
> 
>   

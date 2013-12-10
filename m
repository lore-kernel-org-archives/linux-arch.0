From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 tip/core/locking 6/7] locking: Add an
 smp_mb__after_unlock_lock() for UNLOCK+LOCK barrier
Date: Tue, 10 Dec 2013 13:37:26 +0100
Message-ID: <20131210123726.GE13532@twins.programming.kicks-ass.net>
References: <20131210012738.GA24317@linux.vnet.ibm.com>
 <1386638883-25379-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1386638883-25379-6-git-send-email-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47434 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3LJMiH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2013 07:38:07 -0500
Content-Disposition: inline
In-Reply-To: <1386638883-25379-6-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, darren@dvhart.com, fweisbec@gmail.com, sbw@mit.edu, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Dec 09, 2013 at 05:28:02PM -0800, Paul E. McKenney wrote:
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index f89da808ce31..abf645799991 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -84,4 +84,6 @@ do {									\
>  	___p1;								\
>  })
>  
> +#define smp_mb__after_unlock_lock()	do { } while (0)
> +
>  #endif /* _ASM_POWERPC_BARRIER_H */

Didn't ben said ppc actually violates the current unlock+lock assumtion
and therefore this barrier woulnd't actually be a nop on ppc

From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 15/18] sh: Use generic idle thread allocation
Date: Sat, 21 Apr 2012 12:18:20 +0900
Message-ID: <20120421031819.GF22189@linux-sh.org>
References: <20120420122120.097464672@linutronix.de>
 <20120420124557.855203626@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:49633 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab2DUDTY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2012 23:19:24 -0400
Content-Disposition: inline
In-Reply-To: <20120420124557.855203626@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On Fri, Apr 20, 2012 at 01:05:54PM -0000, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
>  arch/sh/Kconfig                 |    1 +
>  arch/sh/include/asm/processor.h |    4 ----
>  arch/sh/kernel/smp.c            |   14 +-------------
>  3 files changed, 2 insertions(+), 17 deletions(-)
> 
Looks good to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>

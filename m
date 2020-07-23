From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 16:26:23 +0200
Message-ID: <20200723142623.GS5523@worktop.programming.kicks-ass.net>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
 <87imeextf3.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGWO0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:26:36 -0400
Content-Disposition: inline
In-Reply-To: <87imeextf3.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Belits <abelits@marvell.com>, "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

On Thu, Jul 23, 2020 at 03:17:04PM +0200, Thomas Gleixner wrote:

>   2) Instruction synchronization
> 
>      Trying to do instruction synchronization delayed is a clear recipe
>      for hard to diagnose failures. Just because it blew not up in your
>      face does not make it correct in any way. It's broken by design and
>      violates _all_ rules of safe instruction patching and introduces a
>      complete trainwreck in x86 NMI processing.
> 
>      If you really think that this is correct, then please have at least
>      the courtesy to come up with a detailed and precise argumentation
>      why this is a valid approach.
> 
>      While writing that up you surely will find out why it is not.

So delaying the sync_core() IPIs for kernel text patching _might_ be
possible, but it very much wants to be a separate patchset and not
something hidden inside a 'gem' like this.

Return-Path: <SRS0=uZ41=BC=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 11:49:44 -0400
Date: Thu, 23 Jul 2020 17:49:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/13] "Task_isolation" mode
Message-ID: <20200723154933.GB709@worktop.programming.kicks-ass.net>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
 <87imeextf3.fsf@nanos.tec.linutronix.de>
 <831e023422aa0e4cb3da37ceef6fdcd5bc854682.camel@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831e023422aa0e4cb3da37ceef6fdcd5bc854682.camel@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@kernel.org" <mingo@kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <20200723154933.B4iR-KsH03TWSrmBts0qtkaqjiYWFBgl6wzRouiGoXw@z>

On Thu, Jul 23, 2020 at 03:18:42PM +0000, Alex Belits wrote:
> On Thu, 2020-07-23 at 15:17 +0200, Thomas Gleixner wrote:
> > 
> > Without going into details of the individual patches, let me give you a
> > high level view of this series:
> > 
> >   1) Entry code handling:
> > 
> >      That's completely broken vs. the careful ordering and instrumentation
> >      protection of the entry code. You can't just slap stuff randomly
> >      into places which you think are safe w/o actually trying to understand
> >      why this code is ordered in the way it is.
> > 
> >      This clearly was never built and tested with any of the relevant
> >      debug options enabled. Both build and boot would have told you.
> 
> This is intended to avoid a race condition when entry or exit from isolation
> happens at the same time as an event that requires synchronization. The idea
> is, it is possible to insulate the core from all events while it is running
> isolated task in userspace, it will receive those calls normally after
> breaking isolation and entering kernel, and it will synchronize itself on
> kernel entry.

'What does noinstr mean? and why do we have it" -- don't dare touch the
entry code until you can answer that.

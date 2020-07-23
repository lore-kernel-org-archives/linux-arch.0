From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 16:29:02 +0200
Message-ID: <20200723142902.GT5523@worktop.programming.kicks-ass.net>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
 <87imeextf3.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgGWO3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:29:18 -0400
Content-Disposition: inline
In-Reply-To: <87imeextf3.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Belits <abelits@marvell.com>, "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

On Thu, Jul 23, 2020 at 03:17:04PM +0200, Thomas Gleixner wrote:
>   8) Changelogs
> 
>      Most of the changelogs have something along the lines:
> 
>      'task isolation does not want X, so do Y to make it not do X'
> 
>      without any single line of explanation why this approach was chosen
>      and why it is correct under all circumstances and cannot have nasty
>      side effects.
> 
>      It's not the job of the reviewers/maintainers to figure this out.
> 
> Please come up with a coherent design first and then address the
> identified issues one by one in a way which is palatable and reviewable.
> 
> Throwing a big pile of completely undocumented 'works for me' mess over
> the fence does not get you anywhere, not even to the point that people
> are willing to review it in detail.

This.. as presented it is an absolutely unreviewable pile of junk. It
presents code witout any coherent problem description and analysis. And
the patches are not split sanely either.

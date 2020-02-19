From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Date: Wed, 19 Feb 2020 18:07:25 +0100
Message-ID: <20200219170725.GO18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
 <20200219103126.33f67cf3@gandalf.local.home>
 <20200219165650.GB32346@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSRHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:07:54 -0500
Content-Disposition: inline
In-Reply-To: <20200219165650.GB32346@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>

On Wed, Feb 19, 2020 at 05:56:50PM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 10:31:26AM -0500, Steven Rostedt wrote:
> > Probably should document somewhere (in a comment above nmi_enter()?)
> > that we allow nmi_enter() to nest up to 15 times.
> 
> Yah, and can we make the BUG_ON() WARN_ON or so instead, so that there's
> at least a chance to be able to catch it for debugging. Or is the box
> going to be irreparably wedged after the 4 bits overflow?

It's going to be fairly buggered, because at that point in_nmi() is
going to be false again. It might survive for a little, it might not.

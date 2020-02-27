Return-Path: <SRS0=BIEI=4P=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729076AbgB0Nel (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 08:34:41 -0500
Date: Thu, 27 Feb 2020 14:34:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200227133437.GB21795@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
 <20200225030905.GB28329@lenoir>
 <20200225154111.GM18400@hirez.programming.kicks-ass.net>
 <20200225221031.GB9599@lenoir>
 <20200227091042.GG18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227091042.GG18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
Message-ID: <20200227133438.33etwTahbph1YSeWU29dJ0N6URrzZBmkrWhuq_0cGyQ@z>

On Thu, Feb 27, 2020 at 10:10:42AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 11:10:32PM +0100, Frederic Weisbecker wrote:
> > So here is my previous proposal, based on a simple counter, this time
> > with comments and a few fixes:
> 
> I've presumed your SoB and made this your patch.

Ok, thanks!

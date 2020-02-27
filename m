From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Date: Thu, 27 Feb 2020 14:34:38 +0100
Message-ID: <20200227133437.GB21795@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
 <20200225030905.GB28329@lenoir>
 <20200225154111.GM18400@hirez.programming.kicks-ass.net>
 <20200225221031.GB9599@lenoir>
 <20200227091042.GG18400@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200227091042.GG18400@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 27, 2020 at 10:10:42AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 11:10:32PM +0100, Frederic Weisbecker wrote:
> > So here is my previous proposal, based on a simple counter, this time
> > with comments and a few fixes:
> 
> I've presumed your SoB and made this your patch.

Ok, thanks!

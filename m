From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Date: Wed, 12 Feb 2020 16:04:40 +0100
Message-ID: <20200212150440.GT14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.894657838@infradead.org>
 <20200212092539.135934e1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200212092539.135934e1@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 12, 2020 at 09:25:39AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:32:15 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because do_nmi() must not call into tracing outside of
> > nmi_enter()/nmi_exit(), these functions must be notrace.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/cpu/common.c |    4 ++--
> >  arch/x86/kernel/nmi.c        |    6 ++++++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> 
> This entire file is notrace:
> 
>  arch/x86/kernel/cpu/Makefile:
> 
>    CFLAGS_REMOVE_common.o = -pg

Urgh, I hate it that that annotation is so hard to find :/ Also, there
seem to be various flavours of that Makefile magic around.

  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)

is another variant I encountered.
